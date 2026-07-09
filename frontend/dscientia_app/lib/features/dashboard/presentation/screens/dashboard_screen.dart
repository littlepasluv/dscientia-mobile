import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _showComingSoonMessage(BuildContext context, String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$featureName will be available in the next MVP step.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DscienTia'),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () => _showComingSoonMessage(context, 'Notifications'),
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroPanel(
                title: 'Community Resilience Dashboard',
                subtitle:
                    'Track community risks, generate AI-powered insights, and prepare evidence-based actions for local resilience.',
                label: 'IBM Builder MVP',
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 24),
              const _SectionTitle(
                title: 'Today’s Snapshot',
                subtitle: 'Baseline indicators for the MVP demo.',
              ),
              const SizedBox(height: 16),
              const _MetricsGrid(),
              const SizedBox(height: 24),
              const _SectionTitle(
                title: 'MVP Actions',
                subtitle: 'Start the core community resilience workflow.',
              ),
              const SizedBox(height: 16),
              _ActionCard(
                icon: Icons.auto_awesome_outlined,
                title: 'AI Insight for Community Resilience',
                description:
                    'Generate a structured insight from a community risk report, including summary, priority, suggested action, and ethical note.',
                buttonLabel: 'Start AI Insight Flow',
                onPressed: () =>
                    _showComingSoonMessage(context, 'AI Insight Flow'),
              ),
              const SizedBox(height: 16),
              _ActionCard(
                icon: Icons.assignment_outlined,
                title: 'Submit Community Risk Report',
                description:
                    'Capture a local issue such as flooding, public safety, health risk, infrastructure damage, or community needs.',
                buttonLabel: 'Create Risk Report',
                onPressed: () =>
                    _showComingSoonMessage(context, 'Community Risk Report'),
              ),
              const SizedBox(height: 24),
              const _RoadmapCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroPanel extends StatelessWidget {
  final String title;
  final String subtitle;
  final String label;
  final ColorScheme colorScheme;

  const _HeroPanel({
    required this.title,
    required this.subtitle,
    required this.label,
    required this.colorScheme,
  });

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
            Chip(label: Text(label), backgroundColor: colorScheme.surface),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionTitle({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  const _MetricsGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 720;
        final spacing = isWide ? 16.0 : 12.0;
        final cardWidth = isWide
            ? (constraints.maxWidth - spacing) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children:
              const [
                _MetricCard(
                  icon: Icons.report_problem_outlined,
                  title: 'Open Reports',
                  value: '0',
                  description: 'Ready for report data',
                ),
                _MetricCard(
                  icon: Icons.psychology_outlined,
                  title: 'AI Insights',
                  value: '0',
                  description: 'Waiting for first analysis',
                ),
                _MetricCard(
                  icon: Icons.priority_high_outlined,
                  title: 'Priority Risks',
                  value: '0',
                  description: 'No active risk yet',
                ),
                _MetricCard(
                  icon: Icons.task_alt_outlined,
                  title: 'Recommended Actions',
                  value: '0',
                  description: 'No action generated yet',
                ),
              ].map((card) {
                return SizedBox(width: cardWidth, child: card);
              }).toList(),
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String description;

  const _MetricCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
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
                    value,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String buttonLabel;
  final VoidCallback onPressed;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: colorScheme.primaryContainer,
              foregroundColor: colorScheme.onPrimaryContainer,
              child: Icon(icon),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onPressed,
              icon: const Icon(Icons.arrow_forward),
              label: Text(buttonLabel),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoadmapCard extends StatelessWidget {
  const _RoadmapCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _RoadmapHeader(),
            SizedBox(height: 16),
            _RoadmapItem(
              status: 'Current',
              title: 'MVP-001 Basic Dashboard Skeleton',
              description: 'Create the first visible product dashboard.',
            ),
            _RoadmapItem(
              status: 'Next',
              title: 'MVP-002 Community Risk Report Form',
              description: 'Capture local risks and community issues.',
            ),
            _RoadmapItem(
              status: 'Next',
              title: 'MVP-003 AI Insight Result Screen',
              description:
                  'Display AI-generated summary, priority, action, and ethical note.',
            ),
          ],
        ),
      ),
    );
  }
}

class _RoadmapHeader extends StatelessWidget {
  const _RoadmapHeader();

  @override
  Widget build(BuildContext context) {
    return Text(
      'IBM Builder MVP Roadmap',
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _RoadmapItem extends StatelessWidget {
  final String status;
  final String title;
  final String description;

  const _RoadmapItem({
    required this.status,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.check_circle_outline),
      title: Text(title),
      subtitle: Text(description),
      trailing: Text(status),
    );
  }
}
