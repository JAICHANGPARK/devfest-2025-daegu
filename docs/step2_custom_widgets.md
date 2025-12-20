# Step 2: 고객센터 전용 커스텀 위젯 제작

AI가 사용자에게 단순히 글자로만 답하는 것이 아니라, 구조화된 정보를 아름답게 보여줄 수 있도록 인터렉티브한 위젯들을 개발합니다.

## 1. 커스텀 위젯 만들기
AI가 텍스트 외에도 구조화된 정보를 보여줄 수 있도록 인터렉티브한 위젯들을 작성합니다.

### 📍 FAQ 카드 (`FaqCard`)
질문과 답변을 실시간으로 구독하여 보여주는 위젯입니다. 다음 코드를 작성하세요.

```dart
class FaqCard extends StatelessWidget {
  final ValueNotifier<String?> questionNotifier;
  final ValueNotifier<String?> answerNotifier;
  final VoidCallback? onTap;

  const FaqCard({
    required this.questionNotifier,
    required this.answerNotifier,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ValueListenableBuilder<String?>(
        valueListenable: questionNotifier,
        builder: (context, question, _) {
          return ValueListenableBuilder<String?>(
            valueListenable: answerNotifier,
            builder: (context, answer, _) {
              return ExpansionTile(
                title: Text(question ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(answer ?? ''),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
```

### 📍 카테고리 그리드 (`CategoryGrid`)
문의 유형을 선택할 수 있는 그리드입니다.

```dart
class CategoryGrid extends StatelessWidget {
  final List<CategoryItemData> categories;
  final Function(String id) onCategorySelected;

  const CategoryGrid({
    required this.categories,
    required this.onCategorySelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return InkWell(
          onTap: () => onCategorySelected(category.id),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(category.icon, size: 32, color: Colors.blue),
              const SizedBox(height: 8),
              Text(category.label, style: const TextStyle(fontSize: 12)),
            ],
          ),
        );
      },
    );
  }
}

class CategoryItemData {
  final String id;
  final String label;
  final IconData icon;
  CategoryItemData({required this.id, required this.label, required this.icon});
}
```

### 📍 문의 상태 카드 (`InquiryStatusCard`)
현재 처리 상태를 실시간으로 보여줍니다.

```dart
class InquiryStatusCard extends StatelessWidget {
  final ValueNotifier<String?> titleNotifier;
  final ValueNotifier<String?> statusNotifier;
  final Color statusColor;

  const InquiryStatusCard({
    required this.titleNotifier,
    required this.statusNotifier,
    required this.statusColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ValueListenableBuilder<String?>(
        valueListenable: titleNotifier,
        builder: (context, title, _) {
          return ListTile(
            title: Text(title ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: ValueListenableBuilder<String?>(
              valueListenable: statusNotifier,
              builder: (context, status, _) {
                return Text('상태: ${status ?? ''}');
              },
            ),
            trailing: CircleAvatar(backgroundColor: statusColor, radius: 8),
          );
        },
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
