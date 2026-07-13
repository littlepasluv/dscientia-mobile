import 'package:dio/dio.dart';

import '../dtos/ai_insight_create_request.dart';
import '../dtos/ai_insight_response.dart';

class AiInsightApiClient {
  const AiInsightApiClient(this._dio);

  final Dio _dio;

  Future<AiInsightResponse> generateInsight(
    AiInsightCreateRequest request,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/ai-insights',
      data: request.toJson(),
    );

    return AiInsightResponse.fromJson(
      response.data!['data'] as Map<String, dynamic>,
    );
  }

  Future<AiInsightResponse> showInsight(int aiInsightId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/ai-insights/$aiInsightId',
    );

    return AiInsightResponse.fromJson(
      response.data!['data'] as Map<String, dynamic>,
    );
  }
}
