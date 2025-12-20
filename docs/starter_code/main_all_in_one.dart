import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:genui_google_generative_ai/genui_google_generative_ai.dart';

void main() {
  runApp(const MaterialApp(home: CustomerCenterApp()));
}

class CustomerCenterApp extends StatefulWidget {
  const CustomerCenterApp({super.key});

  @override
  State<CustomerCenterApp> createState() => _CustomerCenterAppState();
}

class _CustomerCenterAppState extends State<CustomerCenterApp> {
  late final GenUiConversation _conversation;

  @override
  void initState() {
    super.initState();
    // [Step 4] 시스템 프롬프트 수정
    final generator = GoogleGenerativeAiContentGenerator(
      apiKey: const String.fromEnvironment('GOOGLE_API_KEY'),
      modelName: 'models/gemini-3-flash-preview',
      // [Step 3] 카탈로그 아이템 등록
      catalog: Catalog([CoreCatalogItems.text, CoreCatalogItems.column]),
      systemInstruction: '당신은 고객센터 상담원입니다.',
    );

    _conversation = GenUiConversation(
      contentGenerator: generator,
      a2uiMessageProcessor: A2uiMessageProcessor(
        catalogs: [generator.catalog, CoreCatalogItems.asCatalog()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GenUI 고객센터 (All-in-one)')),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List<ChatMessage>>(
              valueListenable: _conversation.conversation,
              builder: (context, messages, _) {
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    if (message is AiUiMessage) {
                      return GenUiSurface(
                        host: _conversation.host,
                        surfaceId: message.surfaceId,
                      );
                    }
                    if (message is UserMessage) {
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(message.text),
                      );
                    }
                    if (message is AiTextMessage) {
                      return ListTile(
                        leading: const Icon(Icons.support_agent),
                        title: Text(message.text),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
              },
            ),
          ),
          TextField(
            onSubmitted: (text) {
              _conversation.sendRequest(UserMessage.text(text));
            },
          ),
        ],
      ),
    );
  }
}

// [Step 2] 여기에 커스텀 위젯(FaqCard 등)을 추가하세요.

// [Step 3] 여기에 CatalogItem 정의를 추가하세요.
