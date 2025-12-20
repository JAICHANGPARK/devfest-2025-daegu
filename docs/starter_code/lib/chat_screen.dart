import 'package:flutter/material.dart';
import 'package:genui/genui.dart';

class ChatScreen extends StatefulWidget {
  final GenUiConversation conversation;
  const ChatScreen({super.key, required this.conversation});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GenUI 고객센터')),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List<ChatMessage>>(
              valueListenable: widget.conversation.conversation,
              builder: (context, messages, _) {
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];

                    if (message is AiUiMessage) {
                      return GenUiSurface(
                        host: widget.conversation.host,
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
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: TextField(controller: _controller)),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              widget.conversation.sendRequest(
                UserMessage.text(_controller.text),
              );
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}
