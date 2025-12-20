import 'package:flutter/material.dart';

class FaqCard extends StatelessWidget {
  final ValueNotifier<String?> questionNotifier;
  final ValueNotifier<String?> answerNotifier;
  final VoidCallback? onTap;

  const FaqCard({
    super.key,
    required this.questionNotifier,
    required this.answerNotifier,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ValueListenableBuilder<String?>(
        valueListenable: questionNotifier,
        builder: (context, question, _) {
          return ValueListenableBuilder<String?>(
            valueListenable: answerNotifier,
            builder: (context, answer, _) {
              return ExpansionTile(
                title: Text(
                  question ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(answer ?? ''),
                  ),
                  if (onTap != null)
                    OverflowBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: onTap,
                          child: const Text('도움이 안 됐나요?'),
                        ),
                      ],
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
