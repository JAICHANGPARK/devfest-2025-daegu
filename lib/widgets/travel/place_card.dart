
import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final String name;
  final String summary;       // 'description' 대신 'summary' 사용
  final VoidCallback? onTap;  // 클릭 이벤트를 받기 위해 추가

  const PlaceCard({
    super.key,
    required this.name,
    required this.summary,
    this.onTap,               // 선택적 인자로 추가
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell( // 터치 효과를 위해 InkWell 사용
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(summary, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              if (onTap != null)
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text("자세히 보기 >", style: TextStyle(color: Colors.blue)),
                )
            ],
          ),
        ),
      ),
    );
  }
}