# Step 1: 기본적인 채팅 인터페이스 구현

이 단계에서는 `genui` 패키지를 사용하여 AI와 대화할 수 있는 화면을 구성합니다.

## 1. GenUI 라이브러리 이해하기
`genui`는 LLM(대규모 언어 모델)의 응답에 따라 선언적으로 UI를 생성해주는 Flutter 패키지입니다.

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

## 4. 실습 과제
`lib/main.dart`에서 `ChatScreen`을 홈 화면으로 설정하고, API 키가 정상적으로 주입되는지 확인해 보세요.

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GenUI Customer Center',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ChatScreen(), // 채팅 화면을 시작 페이지로!
    );
  }
}
```

---
AI와 텍스트 대화가 가능한가요? 이제 **[Step 2: 커스텀 위젯 제작](./step2_custom_widgets.md)**에서 고객센터만의 특별한 UI를 만들어 봅시다.
