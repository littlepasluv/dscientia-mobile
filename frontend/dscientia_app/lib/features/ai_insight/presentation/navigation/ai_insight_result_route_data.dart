import '../../../reports/domain/entities/community_risk_report_draft.dart';
import '../../data/dtos/ai_insight_response.dart';

class AiInsightResultRouteData {
  const AiInsightResultRouteData({required this.report, this.backendInsight});

  final CommunityRiskReportDraft report;
  final AiInsightResponse? backendInsight;
}
