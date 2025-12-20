import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:genui_google_generative_ai/genui_google_generative_ai.dart';
import 'chat_screen.dart';
import 'catalog.dart';

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

    // [Step 1] Generator 설정
    final generator = GoogleGenerativeAiContentGenerator(
      apiKey: const String.fromEnvironment('GOOGLE_API_KEY'),
      modelName: 'models/gemini-1.5-flash',
      catalog: customerCenterCatalog,
      systemInstruction: '당신은 고객센터 상담원입니다. 질문에 친절하게 답해주세요.',
    );

    // [Step 1] Conversation 생성
    _conversation = GenUiConversation(
      contentGenerator: generator,
      a2uiMessageProcessor: A2uiMessageProcessor(
        catalogs: [customerCenterCatalog, CoreCatalogItems.asCatalog()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChatScreen(conversation: _conversation);
  }
}
