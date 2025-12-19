# Step 2: 고객센터 전용 커스텀 위젯 제작

AI가 사용자에게 단순히 글자로만 답하는 것이 아니라, 구조화된 정보를 아름답게 보여줄 수 있도록 인터렉티브한 위젯들을 개발합니다.

## 1. FAQ 카드 만들기 (`lib/widgets/faq_card.dart`)
간단하게 질문과 답변을 보여주는 위젯입니다.

```dart
class FaqCard extends StatelessWidget {
  final String question;
  final String answer;
  final VoidCallback? onTap;

  const FaqCard({required this.question, required this.answer, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: [Padding(padding: const EdgeInsets.all(16), child: Text(answer))],
      ),
    );
  }
}
```

## 2. 카테고리 그리드 (`lib/widgets/category_grid.dart`)
문의 종류를 고를 수 있는 아이콘 그리드입니다.

## 3. 문의 상태 카드 (`lib/widgets/inquiry_status_card.dart`)
"접수됨", "처리 중", "완료" 등의 상태를 시각적으로 보여줍니다.

## 실습 가이드
*   `lib/widgets/` 폴더 내에 각 파일이 있는지 확인하세요.
*   디자인을 더 예쁘게 다듬고 싶다면 `Card`, `Container`, `Gradient` 등을 활용해 보세요.
*   **주의**: GenUI와 연결할 때 위젯의 생성자(Constructor) 파라미터 이름이 데이터 스키마와 일치해야 합니다.

---
위젯들이 준비되었다면, 이제 AI에게 이 위젯들을 "선물"해 줄 시간입니다. **[Step 3](./step3_catalog_genui.md)**로 이동하세요.
