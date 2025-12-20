# Step 1: 기본적인 채팅 인터페이스 구현

이 단계에서는 `genui` 패키지를 사용하여 AI와 대화할 수 있는 화면을 구성합니다.

## 1. GenUI 라이브러리 이해하기
`genui`는 LLM(대규모 언어 모델)의 응답에 따라 선언적으로 UI를 생성해주는 Flutter 패키지입니다. 텍스트 응답을 아름답게 보여주기 위해 마크다운을 지원하는 `MarkdownWidget`(`lib/utils.dart`)을 활용합니다.

## 2. ChatScreen 구성 및 데이터 흐름
`genui` 패키지는 LLM과의 대화를 관리하는 `GenUiConversation`과 UI 메시지를 해석하는 `A2uiMessageProcessor`를 중심으로 동작합니다.

```dart
// [Step 1] GenUiConversation 초기화 예시
final generator = GoogleGenerativeAiContentGenerator(
  apiKey: const String.fromEnvironment('GOOGLE_API_KEY'),
  modelName: 'models/gemini-3-flash-preview',
  catalog: customerCenterCatalog,
);

final conversation = GenUiConversation(
  contentGenerator: generator,
  a2uiMessageProcessor: A2uiMessageProcessor(
    catalogs: [customerCenterCatalog, CoreCatalogItems.asCatalog()],
  ),
);
```

## 3. 메시지 모델링
`lib/message.dart`에 정의된 `Message` 클래스는 채팅의 이력을 관리합니다.

```dart
class Message {
  final String text;
  final bool isUser;
  // ...
}
```

### 📍 채팅 인터페이스 고도화
단순한 텍스트 리스트를 넘어, AI와 사용자의 메시지를 구분하고 Markdown을 지원하도록 UI를 개선합니다.

```dart
// [Step 1] ListView.builder의 구성을 아래와 같이 변경합니다.
ListView.builder(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
  itemCount: messages.length,
  itemBuilder: (context, index) {
    final message = messages[index];

    if (message is AiUiMessage) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: GenUiSurface(
          host: _conversation.host,
          surfaceId: message.surfaceId,
        ),
      );
    }

    if (message is AiTextMessage) {
      return _buildAiMessage(context, message.text);
    }

    if (message is UserMessage) {
      return _buildUserMessage(context, message.text);
    }

    return const SizedBox.shrink();
  },
)

// 메시지 말풍선을 그려주는 헬퍼 메서드들입니다.
Widget _buildAiMessage(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withAlpha(30),
          radius: 18,
          child: Icon(Icons.support_agent, size: 20, color: Theme.of(context).primaryColor),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: MarkdownWidget(text: text), // markdown 지원
          ),
        ),
        const SizedBox(width: 40),
      ],
    ),
  );
}

Widget _buildUserMessage(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(width: 60),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
            ),
          ),
        ),
      ],
    ),
  );
}
```

---
AI와 텍스트 대화가 가능한가요? 이제 **[Step 2: 커스텀 위젯 제작](./step2_custom_widgets.md)**에서 고객센터만의 특별한 UI를 만들어 봅시다.
