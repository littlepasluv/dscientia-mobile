import 'package:flutter/material.dart';

import '../../../reports/domain/entities/community_risk_report_draft.dart';
import '../../domain/entities/ai_insight.dart';
import '../../domain/services/mock_ai_insight_generator.dart';

class AiInsightResultScreen extends StatelessWidget {
  final CommunityRiskReportDraft report;

  const AiInsightResultScreen({required this.report, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final insight = const MockAiInsightGenerator().generate(report);

    return Scaffold(
      appBar: AppBar(title: const Text('AI Insight Result')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _InsightHero(
                priorityLabel: insight.priorityLabel,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 24),
              _ReportContextCard(report: report),
              const SizedBox(height: 16),
              _InsightCard(
                icon: Icons.summarize_outlined,
                title: 'AI Risk Summary',
                content: insight.summary,
              ),
              const SizedBox(height: 16),
              _InsightCard(
                icon: Icons.priority_high_outlined,
                title: 'Priority Assessment',
                content:
                    'Priority level: ${insight.priorityLabel}. ${insight.priorityRationale}',
              ),
              const SizedBox(height: 16),
              _InsightCard(
                icon: Icons.task_alt_outlined,
                title: 'Suggested Community Action',
                content: insight.suggestedAction,
              ),
              const SizedBox(height: 16),
              _ActionStepsCard(insight: insight),
              const SizedBox(height: 16),
              _InsightCard(
                icon: Icons.verified_user_outlined,
                title: 'Ethical AI Note',
                content: insight.ethicalNote,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back'),
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

class _ActionStepsCard extends StatelessWidget {
  final AiInsight insight;

  const _ActionStepsCard({required this.insight});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommended Action Steps',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...insight.actionSteps.map(
              (step) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline, size: 20),
                    const SizedBox(width: 8),
                    Expanded(child: Text(step)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
