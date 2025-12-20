import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';
import 'widgets/travel/place_card.dart';
import 'widgets/faq_card.dart';
import 'widgets/category_grid.dart';
import 'widgets/inquiry_status_card.dart';

final placeCardItem = CatalogItem(
  name: 'place_card',
  dataSchema: Schema.object(
    description: 'Displays a travel destination with a name and summary.',
    properties: {
      'name': Schema.string(description: 'Name of the place'),
      'summary': Schema.string(description: 'Short description'),
    },
    required: ['name', 'summary'],
  ),
  widgetBuilder: (CatalogItemContext context) {
    final data = context.data as Map<String, dynamic>;

    return PlaceCard(
      name: data['name'] ?? 'Unknown',
      summary: data['summary'] ?? '',
      onTap: () {
        context.dispatchEvent(
          UserActionEvent(
            sourceComponentId: context.id,
            name: 'viewDetails',
            context: {'placeName': data['name']},
          ),
        );
      },
    );
  },
);

final faqCardItem = CatalogItem(
  name: 'faq_card',
  dataSchema: Schema.object(
    description: 'Displays a question and answer card.',
    properties: {
      'question': A2uiSchemas.stringReference(description: 'The question'),
      'answer': A2uiSchemas.stringReference(description: 'The answer'),
    },
    required: ['question', 'answer'],
  ),
  widgetBuilder: (CatalogItemContext context) {
    final data = context.data as Map<String, dynamic>;
    return FaqCard(
      questionNotifier: context.dataContext.subscribeToString(data['question']),
      answerNotifier: context.dataContext.subscribeToString(data['answer']),
      onTap: () {
        context.dispatchEvent(
          UserActionEvent(
            sourceComponentId: context.id,
            name: 'notHelpful',
            context: {'question': data['question']},
          ),
        );
      },
    );
  },
);

final categoryGridItem = CatalogItem(
  name: 'category_grid',
  dataSchema: Schema.object(
    description: 'Displays a grid of inquiry categories.',
    properties: {
      'categories': Schema.list(
        description: 'List of categories',
        items: Schema.object(
          properties: {
            'id': Schema.string(),
            'label': Schema.string(),
            'iconName': Schema.string(
              description: 'Name of the icon (e.g., info, help, payment)',
            ),
          },
          required: ['id', 'label', 'iconName'],
        ),
      ),
    },
    required: ['categories'],
  ),
  widgetBuilder: (CatalogItemContext context) {
    final data = context.data as Map<String, dynamic>;
    final categoriesData = data['categories'] as List<dynamic>? ?? [];

    final categories = categoriesData.map((c) {
      final iconName = c['iconName'] as String;
      IconData icon;
      switch (iconName) {
        case 'info':
          icon = Icons.info;
          break;
        case 'help':
          icon = Icons.help;
          break;
        case 'payment':
          icon = Icons.payment;
          break;
        case 'person':
          icon = Icons.person;
          break;
        case 'settings':
          icon = Icons.settings;
          break;
        default:
          icon = Icons.help_outline;
      }
      return CategoryItemData(
        id: c['id'] as String,
        label: c['label'] as String,
        icon: icon,
      );
    }).toList();

    return CategoryGrid(
      categories: categories,
      onCategorySelected: (id) {
        context.dispatchEvent(
          UserActionEvent(
            sourceComponentId: context.id,
            name: 'categorySelected',
            context: {'categoryId': id},
          ),
        );
      },
    );
  },
);

final inquiryStatusCardItem = CatalogItem(
  name: 'inquiry_status_card',
  dataSchema: Schema.object(
    description: 'Displays the status of an inquiry.',
    properties: {
      'title': A2uiSchemas.stringReference(description: 'The title'),
      'status': A2uiSchemas.stringReference(description: 'The status'),
      'date': Schema.string(),
      'statusType': Schema.string(
        description: 'Type of status: pending, resolved, inProgress',
      ),
    },
    required: ['title', 'status', 'date'],
  ),
  widgetBuilder: (CatalogItemContext context) {
    final data = context.data as Map<String, dynamic>;
    final statusType = data['statusType'] as String?;
    Color statusColor;
    switch (statusType) {
      case 'resolved':
        statusColor = Colors.green;
        break;
      case 'inProgress':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.blue;
    }

    return InquiryStatusCard(
      titleNotifier: context.dataContext.subscribeToString(data['title']),
      statusNotifier: context.dataContext.subscribeToString(data['status']),
      date: data['date'] ?? '',
      statusColor: statusColor,
    );
  },
);

// // [수정 완료] items: 파라미터 삭제 -> 대괄호로 바로 리스트 전달
// final travelCatalog = Catalog([
//   placeCardItem,
//   verticalLayoutItem, // 위에서 만든 Column
//   travelCarousel,     // 제공해주신 Carousel
// ]);
//

final Catalog customerCenterCatalog = Catalog([
  CoreCatalogItems.button,
  CoreCatalogItems.column,
  CoreCatalogItems.text,
  CoreCatalogItems.imageFixedSize,
  faqCardItem,
  categoryGridItem,
  inquiryStatusCardItem,
], catalogId: 'devfest.com:customer_center_v0');

final Catalog travelAppCatalog = customerCenterCatalog;
