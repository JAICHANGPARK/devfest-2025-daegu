import 'package:devfest_2025_daegu/tools/booking_service.dart';
import 'package:devfest_2025_daegu/tools/list_hotels.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:genui_google_generative_ai/genui_google_generative_ai.dart';
import 'chat_screen.dart';
import 'catalog.dart';
import 'message.dart'; // 위에서 만든 카탈로그

void main() {
  runApp(const MaterialApp(home: TravelAgentApp()));
}

class TravelAgentApp extends StatefulWidget {
  const TravelAgentApp({super.key});

  @override
  State<TravelAgentApp> createState() => _TravelAgentAppState();
}

class _TravelAgentAppState extends State<TravelAgentApp> {
  late final GenUiConversation _conversation;

  @override
  void initState() {
    super.initState();

    // 1. Generator 설정 (참가자 실습)
    final generator = GoogleGenerativeAiContentGenerator(
      apiKey: const String.fromEnvironment('GENAI_API_KEY'),
      modelName: 'models/gemini-3-flash-preview',
      // 최신 모델
      catalog: customerCenterCatalog,
      // 우리가 만든 도구 상자 주입
      // [핵심] 우리가 만든 검색 주입기 연결!
      // serviceFactory: createSearchEnabledService,

      // [시스템 프롬프트] 검색 결과와 이미지를 사용하는 방법 지시
      additionalTools: [
        ListHotelsTool(onListHotels: BookingService.instance.listHotels),
      ],
      systemInstruction: '''
# Instructions

You are a helpful customer center assistant. Your job is to help customers
with their inquiries, providing information from FAQ or guiding them through 
the process of submitting a request.

## Conversation flow

1.  Greeting and Category Selection: Start by greeting the user and presenting 
    the inquiry categories using the `category_grid`.

2.  FAQ Search: If the user has a specific question, search for relevant 
    information and present it using the `faq_card`. If the provided answer 
    is not helpful, offer to connect them with a human agent or submit a formal 
    inquiry.

3.  Inquiry Submission: If the user needs to submit an inquiry, collect 
    necessary information (title, description) and provide a confirmation 
    using the `inquiry_status_card` with a 'pending' status.

4.  Status Check: If the user wants to check the status of existing inquiries, 
    show their recent inquiries using `inquiry_status_card`.

IMPORTANT: Always be polite and helpful. Use the UI components as much as 
possible to provide a structured experience.

## Controlling the UI

Use the provided tools to build and manage the user interface in response to the
user's requests. To display or update a UI, you must first call the
`surfaceUpdate` tool to define all the necessary components. After defining the
components, you must call the `beginRendering` tool to specify the root
component that should be displayed.

Once you add or update a surface and are waiting for user input, the
conversation turn is complete, and you should call the provideFinalOutput tool.

## UI Components

- FaqCard: Use this to display a single FAQ item (question and answer).
- CategoryGrid: Use this at the beginning or when the user wants to switch topics.
- InquiryStatusCard: Use this to show the progress of an inquiry. Use 'pending', 'inProgress', or 'resolved' for statusType.
''',
    );

    // 2. Conversation & Manager 생성 (참가자 실습)
    _conversation = GenUiConversation(
      contentGenerator: generator,
      a2uiMessageProcessor: A2uiMessageProcessor(
        catalogs: [travelAppCatalog, CoreCatalogItems.asCatalog()],
      ),
      // AI가 텍스트로 답할 때
      onSurfaceAdded: _handleSurfaceAdded,
      onTextResponse: (text) => print("AI Text: $text"),
      // AI가 에러낼 때
      onError: (error) => print("Error: ${error.error}"),
    );
  }

  final List<MessageController> _messages = [];

  void _handleSurfaceAdded(SurfaceAdded surface) {
    if (!mounted) return;
    setState(() {
      _messages.add(MessageController(surfaceId: surface.surfaceId));
    });
    // _scrollToBottom();
  }

  @override
  void dispose() {
    _conversation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 채팅 화면으로 Conversation 전달
    return ChatScreen(conversation: _conversation);
  }
}
