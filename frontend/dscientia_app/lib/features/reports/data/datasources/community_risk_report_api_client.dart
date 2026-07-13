import 'package:dio/dio.dart';

import '../dtos/community_risk_report_create_request.dart';
import '../dtos/community_risk_report_response.dart';

class CommunityRiskReportApiClient {
  const CommunityRiskReportApiClient(this._dio);

  final Dio _dio;

  Future<CommunityRiskReportResponse> createReport(
    CommunityRiskReportCreateRequest request,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/reports',
      data: request.toJson(),
    );

    return CommunityRiskReportResponse.fromJson(
      response.data!['data'] as Map<String, dynamic>,
    );
  }

  Future<List<CommunityRiskReportResponse>> listReports() async {
    final response = await _dio.get<Map<String, dynamic>>('/reports');

    final data = response.data!['data'] as List<dynamic>;

    return data
        .map(
          (item) => CommunityRiskReportResponse.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<CommunityRiskReportResponse> showReport(int reportId) async {
    final response = await _dio.get<Map<String, dynamic>>('/reports/$reportId');

    return CommunityRiskReportResponse.fromJson(
      response.data!['data'] as Map<String, dynamic>,
    );
  }
}
