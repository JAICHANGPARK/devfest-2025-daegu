# Step 2: 고객센터 전용 커스텀 위젯 제작

AI가 사용자에게 단순히 글자로만 답하는 것이 아니라, 구조화된 정보를 아름답게 보여줄 수 있도록 인터렉티브한 위젯들을 개발합니다.

## 1. 커스텀 위젯 만들기
AI가 텍스트 외에도 구조화된 정보를 보여줄 수 있도록 인터렉티브한 위젯들을 작성합니다.

### 📍 FAQ 카드 (`FaqCard`)
질문과 답변을 보여주는 위젯입니다. 다음 코드를 작성하세요.

```dart
class FaqCard extends StatelessWidget {
  final String question;
  final String answer;
  final VoidCallback? onTap;

  const FaqCard({required this.question, required this.answer, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(answer),
          ),
        ],
      ),
    );
  }
}
```

## 2. 코드는 어디에 넣나요? (중요!)
자신이 선택한 시작 코드 방식에 따라 위치가 달라집니다.

*   **방법 A: [구조화된 코드](./starter_code/lib/) 사용 시**
    *   `lib/widgets/faq_card.dart` 파일을 새로 만들고 코드를 붙여넣으세요.
*   **방법 B: [한 파일로 시작하기 (All-in-one)](./starter_code/main_all_in_one.dart) 사용 시**
    *   `lib/main.dart` 파일의 가장 아래쪽, **`// [Step 2] ...`** 주석이 있는 곳에 코드를 추가하세요.

---
위젯 코드를 모두 작성했다면, 이제 AI에게 이 위젯들을 가르쳐 줄 차례입니다. **[Step 3](./step3_catalog_genui.md)**로 이동하세요.
