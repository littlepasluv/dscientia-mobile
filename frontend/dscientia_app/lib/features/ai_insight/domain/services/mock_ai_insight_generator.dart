import '../../../reports/domain/entities/community_risk_report_draft.dart';
import '../entities/ai_insight.dart';

class MockAiInsightGenerator {
  const MockAiInsightGenerator();

  AiInsight generate(CommunityRiskReportDraft report) {
    return AiInsight(
      summary: _summary(report),
      priorityLabel: _priorityLabel(report.urgency),
      priorityRationale: _priorityRationale(report),
      suggestedAction: _suggestedAction(report.category),
      actionSteps: _actionSteps(report.category),
      ethicalNote: _ethicalNote,
    );
  }

  String _summary(CommunityRiskReportDraft report) {
    return 'DscienTia identified this report as a '
        '${report.category.toLowerCase()} issue affecting ${report.location}. '
        'The situation may require coordinated local response, documentation, '
        'and follow-up monitoring.';
  }

  String _priorityLabel(String urgency) {
    switch (urgency.toLowerCase()) {
      case 'high':
        return 'High Priority';
      case 'medium':
        return 'Medium Priority';
      default:
        return 'Low Priority';
    }
  }

  String _priorityRationale(CommunityRiskReportDraft report) {
    return 'This assessment is based on the selected urgency level '
        '(${report.urgency}) and the reported category '
        '(${report.category}). The final decision should still be validated '
        'by local community leaders.';
  }

  String _suggestedAction(String category) {
    switch (category.toLowerCase()) {
      case 'flooding':
        return 'Prioritize drainage inspection, mobility safety, and local coordination.';
      case 'health risk':
        return 'Prioritize basic incident tracking, affected group identification, and health communication.';
      case 'public safety':
        return 'Prioritize location verification, immediate safety mitigation, and local authority notification.';
      case 'infrastructure':
        return 'Prioritize evidence collection, service disruption mapping, and repair escalation.';
      case 'environment':
        return 'Prioritize impact documentation, source identification, and mitigation planning.';
      default:
        return 'Prioritize report validation, affected resident mapping, and practical follow-up planning.';
    }
  }

  List<String> _actionSteps(String category) {
    switch (category.toLowerCase()) {
      case 'flooding':
        return const [
          'Document affected road segments and water depth.',
          'Identify blocked drainage points.',
          'Notify local community leaders.',
          'Prepare a short-term mobility and safety plan.',
        ];
      case 'health risk':
        return const [
          'Collect basic incident details.',
          'Identify affected residents or vulnerable groups.',
          'Coordinate with local health volunteers.',
          'Prepare prevention messaging.',
        ];
      case 'public safety':
        return const [
          'Verify the exact issue location.',
          'Record immediate safety concerns.',
          'Notify the relevant local authority.',
          'Create a short action log for follow-up.',
        ];
      case 'infrastructure':
        return const [
          'Capture photos or supporting evidence.',
          'Identify the service disruption.',
          'Estimate repair urgency.',
          'Escalate to the responsible maintenance channel.',
        ];
      case 'environment':
        return const [
          'Document the visible environmental impact.',
          'Identify possible sources.',
          'Involve community volunteers.',
          'Prepare mitigation steps.',
        ];
      default:
        return const [
          'Validate the report details.',
          'Identify affected residents.',
          'Assign a local follow-up owner.',
          'Prepare a practical response plan.',
        ];
    }
  }

  static const String _ethicalNote =
      'This AI insight is a decision-support summary, not a final authority. '
      'Community leaders should verify facts, consider local context, and avoid '
      'exposing sensitive personal data.';
}
