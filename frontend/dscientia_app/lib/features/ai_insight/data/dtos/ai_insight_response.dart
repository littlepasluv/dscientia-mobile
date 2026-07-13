class AiInsightResponse {
  const AiInsightResponse({
    required this.id,
    required this.reportId,
    required this.insightType,
    required this.riskLevel,
    required this.narrativeSummary,
    required this.summaryPoints,
    required this.recommendedActions,
    required this.confidenceScore,
    required this.modelProvider,
    required this.modelName,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int reportId;
  final String insightType;
  final String riskLevel;
  final String narrativeSummary;
  final List<String> summaryPoints;
  final List<String> recommendedActions;
  final double confidenceScore;
  final String modelProvider;
  final String modelName;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AiInsightResponse.fromJson(Map<String, dynamic> json) {
    return AiInsightResponse(
      id: json['id'] as int,
      reportId: json['report_id'] as int,
      insightType: json['insight_type'] as String,
      riskLevel: json['risk_level'] as String,
      narrativeSummary: json['narrative_summary'] as String,
      summaryPoints: List<String>.from(json['summary_points'] as List),
      recommendedActions: List<String>.from(
        json['recommended_actions'] as List,
      ),
      confidenceScore: (json['confidence_score'] as num).toDouble(),
      modelProvider: json['model_provider'] as String,
      modelName: json['model_name'] as String,
      status: json['status'] as String,
      createdAt: _parseDateTime(json['created_at']),
      updatedAt: _parseDateTime(json['updated_at']),
    );
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value is! String || value.isEmpty) {
      return null;
    }

    return DateTime.tryParse(value);
  }
}
