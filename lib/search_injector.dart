import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:genui_google_generative_ai/genui_google_generative_ai.dart';
import 'package:google_cloud_ai_generativelanguage_v1beta/generativelanguage.dart' as google_ai;

GoogleGenerativeServiceInterface createSearchEnabledService({
  required GoogleGenerativeAiContentGenerator configuration,
}) {
  return _RestSearchInjectorService(
    apiKey: configuration.apiKey ?? '',
    modelName: configuration.modelName,
  );
}

class _RestSearchInjectorService implements GoogleGenerativeServiceInterface {
  final String apiKey;
  final String modelName;
  final http.Client _httpClient = http.Client();

  _RestSearchInjectorService({
    required this.apiKey,
    required this.modelName,
  });

  @override
  Future<void> close() async {
    _httpClient.close();
  }

  @override
  Future<google_ai.GenerateContentResponse> generateContent(
      google_ai.GenerateContentRequest request) async {

    // [에러 수정] toJson() 결과를 Map<String, dynamic>으로 명시적 캐스팅
    final Map<String, dynamic> jsonRequest =
    request.toJson() as Map<String, dynamic>;

    // JSON 조작: "googleSearch": {} 강제 주입
    final List<dynamic> tools = (jsonRequest['tools'] as List<dynamic>?) ?? [];

    // Gemini 2.5 REST API용 도구 정의
    // (REST API는 snake_case 'google_search'를 선호할 수 있으나,
    //  기존 JSON이 camelCase라면 'googleSearch'를 사용. 여기서는 둘 다 호환되도록 camelCase 사용)
    final googleSearchTool = {'googleSearch': {}};

    if (tools.isEmpty) {
      tools.add(googleSearchTool);
    } else {
      // 기존 도구(Function Calling)가 있다면 첫 번째 도구에 병합
      final Map<String, dynamic> firstTool = tools[0] as Map<String, dynamic>;

      // Map 복사 후 수정
      final newFirstTool = Map<String, dynamic>.from(firstTool);
      newFirstTool['googleSearch'] = {};
      tools[0] = newFirstTool;
    }
    jsonRequest['tools'] = tools;

    // REST API 호출
    final uri = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/$modelName:generateContent?key=$apiKey'
    );

    final httpResponse = await _httpClient.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(jsonRequest),
    );

    if (httpResponse.statusCode != 200) {
      throw Exception('Gemini API Error (${httpResponse.statusCode}): ${httpResponse.body}');
    }

    // 응답 JSON -> SDK 객체 복원
    final decodedResponse = jsonDecode(httpResponse.body) as Map<String, dynamic>;
    final responseObj = google_ai.GenerateContentResponse.fromJson(decodedResponse);

    return responseObj;
  }
}