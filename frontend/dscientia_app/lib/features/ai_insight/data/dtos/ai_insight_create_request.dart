class AiInsightCreateRequest {
  const AiInsightCreateRequest({
    required this.reportId,
    this.insightType = 'community_risk_summary',
  });

  final int reportId;
  final String insightType;

  Map<String, dynamic> toJson() {
    return {'report_id': reportId, 'insight_type': insightType};
  }
}
