# Step 3: GenUI 카탈로그 등록 및 연동

이 단계에서는 만든 위젯들을 AI(Gemini)가 인식할 수 있도록 `Catalog`에 등록하는 과정을 배웁니다.

## 1. CatalogItem 정의 (`lib/catalog.dart`)
각 위젯마다 어떤 데이터(JSON)가 필요한지 정의하고, 위젯을 생성하는 함수를 작성합니다.

```dart
// lib/catalog.dart 예시: faq_card 등록
final faqCardItem = CatalogItem(
  name: 'faq_card', // AI가 이 이름으로 호출합니다.
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

## 2. 통합 카탈로그 생성
등록한 항목들을 모아서 하나의 `Catalog` 객체로 만듭니다.

```dart
final Catalog customerCenterCatalog = Catalog([
  CoreCatalogItems.button, // 기본 버튼
  CoreCatalogItems.column, // 레이아웃용
  faqCardItem,
  categoryGridItem,
  inquiryStatusCardItem,
], catalogId: 'customer_center_v1');
```

## 3. 핵심 포인트
*   **Schema**: AI에게 위젯의 용도와 필드 타입을 설명하는 명세서입니다. 설명(description)을 상세히 적을수록 AI가 더 정확하게 위젯을 사용합니다.
*   **Catalog ID**: 카탈로그의 버전을 관리할 때 사용합니다.

---
이제 똑똑한 상담원을 만들 준비가 거의 다 되었습니다. 마지막 단계인 **[Step 4: 프롬프트 엔지니어링](./step4_prompt_engineering.md)**으로 가보시죠!
