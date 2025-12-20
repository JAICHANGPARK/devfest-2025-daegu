# Step 3: GenUI 카탈로그 등록 및 연동

이 단계에서는 만든 위젯들을 AI(Gemini)가 인식할 수 있도록 `Catalog`에 등록하는 과정을 배웁니다.

## 1. CatalogItem 정의
위젯마다 어떤 데이터(JSON)가 필요한지 정의하고, 위젯을 생성하는 함수를 작성합니다. 다음 코드를 복사하세요.

```dart
final faqCardItem = CatalogItem(
  name: 'faq_card', 
  dataSchema: Schema.object(
    description: '질문과 답변 카드를 보여줍니다.',
    properties: {
      'question': Schema.string(description: '질문 내용'),
      'answer': Schema.string(description: '답변 내용'),
    },
    required: ['question', 'answer'],
  ),
  widgetBuilder: (CatalogItemContext context) {
    final data = context.data as Map<String, dynamic>;
    return FaqCard(
      question: data['question'] ?? '',
      answer: data['answer'] ?? '',
    );
  },
);
```

## 2. 코드는 어디에 넣나요?

*   **방법 A: [구조화된 코드](./starter_code/lib/) 사용 시**
    *   `lib/catalog.dart` 파일 상단에 `faqCardItem` 정의를 추가하세요.
*   **방법 B: [한 파일로 시작하기 (All-in-one)](./starter_code/main_all_in_one.dart) 사용 시**
    *   `lib/main.dart` 파일의 **`// [Step 3] 여기에 CatalogItem 정의...`** 주석 아래에 붙여넣으세요.

## 3. 카탈로그에 등록하기
정의한 `faqCardItem`을 실제 AI가 사용하는 리스트에 추가해야 합니다.

*   **방법 A**: `lib/catalog.dart`의 `customerCenterCatalog` 리스트 안에 `faqCardItem`을 추가합니다.
*   **방법 B**: `lib/main.dart` 내 `initState`의 `Catalog([...])` 리스트 안에 `faqCardItem`을 추가합니다.

```dart
// 예시
catalog: Catalog([
  CoreCatalogItems.text,
  CoreCatalogItems.column,
  faqCardItem, // 👈 추가!
]),
```

---
AI에게 도구를 쥐어주었습니다! 이제 어떻게 사용해야 할지 알려줄 시간입니다. **[Step 4](./step4_prompt_engineering.md)**로 이동하세요.
