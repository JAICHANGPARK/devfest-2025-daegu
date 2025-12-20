# Step 3: GenUI 카탈로그 등록 및 연동

이 단계에서는 만든 위젯들을 AI(Gemini)가 인식할 수 있도록 `Catalog`에 등록하는 과정을 배웁니다.

## 1. CatalogItem 정의
위젯마다 어떤 데이터가 필요한지 정의합니다. 단순한 텍스트가 아닌 **'언제든 업데이트될 수 있는 참조형(Reference)'** 데이터 구조를 사용합니다.

```dart
final faqCardItem = CatalogItem(
  name: 'faq_card', 
  dataSchema: Schema.object(
    description: '질문과 답변 카드를 보여줍니다.',
    properties: {
      // A2uiSchemas.stringReference를 사용하면 AI가 데이터를 유연하게 보낼 수 있습니다.
      'question': A2uiSchemas.stringReference(description: '질문 내용'),
      'answer': A2uiSchemas.stringReference(description: '답변 내용'),
    },
    required: ['question', 'answer'],
  ),
  widgetBuilder: (CatalogItemContext context) {
    final data = context.data as Map<String, dynamic>;
    
    // [중요] subscribeToString을 통해 실시간 데이터 변경을 구독합니다.
    final questionNotifier = context.dataContext.subscribeToString(data['question']);
    final answerNotifier = context.dataContext.subscribeToString(data['answer']);
    
    return FaqCard(
      questionNotifier: questionNotifier,
      answerNotifier: answerNotifier,
    );
  },
);
```

### 📍 카테고리 그리드 (`category_grid`)
여러 개의 카테고리 목록을 보여주는 스키마입니다.

```dart
final categoryGridItem = CatalogItem(
  name: 'category_grid',
  dataSchema: Schema.object(
    description: '문의 카테고리 그리드를 표시합니다.',
    properties: {
      'categories': Schema.list(
        description: '카테고리 목록',
        items: Schema.object(
          properties: {
            'id': Schema.string(),
            'label': Schema.string(),
            'iconName': Schema.string(description: '아이콘 이름 (info, help 등)'),
          },
          required: ['id', 'label', 'iconName'],
        ),
      ),
    },
    required: ['categories'],
  ),
  widgetBuilder: (CatalogItemContext context) {
    final data = context.data as Map<String, dynamic>;
    final categoriesData = data['categories'] as List<dynamic>? ?? [];

    final categories = categoriesData.map((c) {
      return CategoryItemData(
        id: c['id'] as String,
        label: c['label'] as String,
        icon: Icons.help_outline, // 실습에서는 고정 아이콘 혹은 간단한 switch문 사용
      );
    }).toList();

    return CategoryGrid(
      categories: categories,
      onCategorySelected: (id) {
        context.dispatchEvent(UserActionEvent(name: 'categorySelected', context: {'categoryId': id}));
      },
    );
  },
);
```

### 📍 문의 상태 카드 (`inquiry_status_card`)

```dart
final inquiryStatusCardItem = CatalogItem(
  name: 'inquiry_status_card',
  dataSchema: Schema.object(
    description: '문의 상태를 표시합니다.',
    properties: {
      'title': A2uiSchemas.stringReference(description: '제목'),
      'status': A2uiSchemas.stringReference(description: '상태 텍스트'),
      'statusType': Schema.string(description: 'pending, resolved 등'),
    },
    required: ['title', 'status'],
  ),
  widgetBuilder: (CatalogItemContext context) {
    final data = context.data as Map<String, dynamic>;
    
    return InquiryStatusCard(
      titleNotifier: context.dataContext.subscribeToString(data['title']),
      statusNotifier: context.dataContext.subscribeToString(data['status']),
      statusColor: data['statusType'] == 'resolved' ? Colors.green : Colors.orange,
    );
  },
);
```

## 2. A2UI 스키마가 무엇인가요?
일반적인 `Schema.string()`은 고정된 문자열만 받을 수 있지만, `A2uiSchemas.stringReference`는:
- **직접 입력된 문자열** (`literalString`)
- **다른 대화 맥락의 값 참조**
- **동적으로 변화하는 값**
등을 모두 수용할 수 있는 GenUI의 진보된 데이터 명세 방식입니다.

## 2. 코드는 어디에 넣나요?

*   **방법 A: [구조화된 코드](./starter_code/lib/) 사용 시**
    *   `lib/catalog.dart` 파일 상단에 `faqCardItem` 정의를 추가하세요.
*   **방법 B: [한 파일로 시작하기 (All-in-one)](./starter_code/main_all_in_one.dart) 사용 시**
    *   `lib/main.dart` 파일의 **`// [Step 3] 여기에 CatalogItem 정의...`** 주석 아래에 위에서 만든 `faqCardItem`, `categoryGridItem`, `inquiryStatusCardItem` 코드를 모두 붙여넣으세요.

## 3. 카탈로그에 등록하기
정의한 `CatalogItem`들을 실제 AI가 사용하고 UI로 보여줄 리스트에 추가해야 합니다. **두 군데(Generator와 MessageProcessor)**를 수정해야 함에 주의하세요!

*   **방법 A**: `lib/catalog.dart`의 `customerCenterCatalog` 리스트 안에 항목들을 추가합니다.
*   **방법 B (All-in-one)**: `lib/main.dart` 내 `initState`에서 다음 두 곳을 수정합니다.

```dart
// 1. AI가 어떤 도구를 쓸지 알려주는 곳
final generator = GoogleGenerativeAiContentGenerator(
  // ...
  catalog: Catalog([
    CoreCatalogItems.text,
    CoreCatalogItems.column,
    faqCardItem,           // 👈 추가
    categoryGridItem,      // 👈 추가
    inquiryStatusCardItem, // 👈 추가
  ]),
  // ...
);

// 2. AI가 호출한 위젯을 실제로 화면에 그리는 곳
_conversation = GenUiConversation(
  contentGenerator: generator,
  a2uiMessageProcessor: A2uiMessageProcessor(
    catalogs: [
      generator.catalog, // 👈 생성자가 가진 카탈로그를 그대로 사용하도록 수정!
      CoreCatalogItems.asCatalog(),
    ],
  ),
);
```

---
AI에게 도구를 쥐어주었습니다! 이제 어떻게 사용해야 할지 알려줄 시간입니다. **[Step 4](./step4_prompt_engineering.md)**로 이동하세요.
