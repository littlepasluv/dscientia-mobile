import 'package:flutter/material.dart';

import '../../../reports/domain/entities/community_risk_report_draft.dart';

class AiInsightResultScreen extends StatelessWidget {
  final CommunityRiskReportDraft report;

  const AiInsightResultScreen({required this.report, super.key});

  String get _priorityLabel {
    switch (report.urgency.toLowerCase()) {
      case 'high':
        return 'High Priority';
      case 'medium':
        return 'Medium Priority';
      default:
        return 'Low Priority';
    }
  }

  String get _mockSummary {
    return 'DscienTia identified this report as a ${report.category.toLowerCase()} issue affecting ${report.location}. '
        'The situation may require coordinated local response, documentation, and follow-up monitoring.';
  }

  String get _mockSuggestedAction {
    switch (report.category.toLowerCase()) {
      case 'flooding':
        return 'Document affected locations, notify local community leaders, identify blocked drainage points, and prepare a short-term mobility and safety plan.';
      case 'health risk':
        return 'Collect basic incident details, identify affected groups, coordinate with local health volunteers, and prepare prevention messaging.';
      case 'public safety':
        return 'Record the issue location, identify immediate safety concerns, notify relevant local authorities, and create a short action log.';
      case 'infrastructure':
        return 'Capture photos or evidence, identify service disruption, prioritize repair urgency, and escalate to the responsible maintenance channel.';
      case 'environment':
        return 'Document the environmental impact, identify possible sources, involve community volunteers, and prepare mitigation steps.';
      default:
        return 'Validate the report, identify affected residents, assign a local follow-up owner, and prepare a practical response plan.';
    }
  }

  String get _ethicalNote {
    return 'This AI insight is a decision-support summary, not a final authority. Community leaders should verify facts, consider local context, and avoid exposing sensitive personal data.';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('AI Insight Result')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _InsightHero(
                priorityLabel: _priorityLabel,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 24),
              _ReportContextCard(report: report),
              const SizedBox(height: 16),
              _InsightCard(
                icon: Icons.summarize_outlined,
                title: 'AI Risk Summary',
                content: _mockSummary,
              ),
              const SizedBox(height: 16),
              _InsightCard(
                icon: Icons.priority_high_outlined,
                title: 'Priority Assessment',
                content:
                    'Priority level: $_priorityLabel. This assessment is based on the selected urgency level and the type of community issue reported.',
              ),
              const SizedBox(height: 16),
              _InsightCard(
                icon: Icons.task_alt_outlined,
                title: 'Suggested Community Action',
                content: _mockSuggestedAction,
              ),
              const SizedBox(height: 16),
              _InsightCard(
                icon: Icons.verified_user_outlined,
                title: 'Ethical AI Note',
                content: _ethicalNote,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Report Form'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InsightHero extends StatelessWidget {
  final String priorityLabel;
  final ColorScheme colorScheme;

  const _InsightHero({required this.priorityLabel, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Chip(
              avatar: const Icon(Icons.auto_awesome_outlined),
              label: const Text('Mock AI Insight'),
              backgroundColor: colorScheme.surface,
            ),
            const SizedBox(height: 16),
            Text(
              'AI-Powered Community Resilience Insight',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Generated from the submitted community risk report as a local MVP preview before IBM/watsonx integration.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 16),
            Chip(
              label: Text(priorityLabel),
              backgroundColor: colorScheme.surface,
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportContextCard extends StatelessWidget {
  final CommunityRiskReportDraft report;

  const _ReportContextCard({required this.report});

  @override
  Widget build(BuildContext context) {
    return _InsightCard(
      icon: Icons.assignment_outlined,
      title: 'Source Report',
      content:
          '${report.title}\n\nCategory: ${report.category}\nLocation: ${report.location}\nUrgency: ${report.urgency}\n\n${report.description}',
    );
  }
}

class _InsightCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _InsightCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: colorScheme.secondaryContainer,
              foregroundColor: colorScheme.onSecondaryContainer,
              child: Icon(icon),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(content),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
