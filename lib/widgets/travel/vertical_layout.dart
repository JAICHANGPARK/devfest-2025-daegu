import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

// 스키마: 자식 위젯들의 ID 리스트를 받습니다.
final _columnSchema = Schema.object(
  properties: {
    'children': Schema.list(
      description: 'A list of child components to display vertically.',
      items: Schema.string(
        description: 'The ID of a child component.',
      ), // 혹은 A2uiSchemas.componentReference 사용 가능
    ),
  },
  required: ['children'],
);

final verticalLayoutItem = CatalogItem(
  name: 'VerticalLayout', // AI가 'Column'이나 'Stack'으로 인식하게 됨
  dataSchema: _columnSchema,
  widgetBuilder: (CatalogItemContext context) {
    final data = context.data as Map<String, dynamic>;
    final childrenIds = (data['children'] as List).cast<String>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: childrenIds.map((id) {
        // 자식 ID를 이용해 실제 위젯을 빌드합니다.
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0), // 간격 추가
          child: context.buildChild(id),
        );
      }).toList(),
    );
  },
);