import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/widgets/app_brand_logo.dart';
import '../../../../shared/widgets/app_hero_card.dart';
import '../../../../shared/widgets/app_page_shell.dart';
import '../../../../shared/widgets/app_section_header.dart';
import '../../../../shared/widgets/app_status_badge.dart';
import '../../../authentication/presentation/providers/authentication_notifier.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _isLoggingOut = false;

  void _showComingSoonMessage(BuildContext context, String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$featureName will be available in the next MVP step.'),
      ),
    );
  }

  Future<void> _logout() async {
    if (_isLoggingOut) {
      return;
    }

    setState(() {
      _isLoggingOut = true;
    });

    try {
      await ref.read(authenticationNotifierProvider.notifier).logout();
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to log out safely. Please try again.'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoggingOut = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authenticationNotifierProvider);
    final showLogoutButton = authState.isAuthenticated || _isLoggingOut;

    return AppPageShell(
      appBar: AppBar(
        title: const AppBrandLogo(),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () => _showComingSoonMessage(context, 'Notifications'),
            icon: const Icon(Icons.notifications_outlined),
          ),
          if (showLogoutButton)
            IconButton(
              tooltip: 'Log out',
              onPressed: _isLoggingOut ? null : _logout,
              icon: _isLoggingOut
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.logout_outlined),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppHeroCard(
            title: 'Community Resilience Dashboard',
            description:
                'Track community risks, generate AI-powered insights, and prepare evidence-based actions for local resilience.',
            icon: Icons.dashboard_customize_outlined,
            trailing: AppStatusBadge(
              label: 'IBM Builder MVP',
              tone: AppStatusTone.info,
              icon: Icons.verified_outlined,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const AppSectionHeader(
            title: 'Today’s Snapshot',
            description: 'Baseline indicators for the MVP demo.',
          ),
          const _MetricsGrid(),
          const SizedBox(height: AppSpacing.lg),
          const AppSectionHeader(
            title: 'MVP Actions',
            description: 'Start the core community resilience workflow.',
          ),
          _ActionCard(
            icon: Icons.auto_awesome_outlined,
            title: 'AI Insight for Community Resilience',
            description:
                'Generate a structured insight from a community risk report, including summary, priority, suggested action, and ethical note.',
            buttonLabel: 'Start AI Insight Flow',
            onPressed: () {
              context.push('/ai-insights/demo');
            },
          ),
          const SizedBox(height: AppSpacing.md),
          _ActionCard(
            icon: Icons.assignment_outlined,
            title: 'Submit Community Risk Report',
            description:
                'Capture a local issue such as flooding, public safety, health risk, infrastructure damage, or community needs.',
            buttonLabel: 'Create Risk Report',
            onPressed: () {
              context.push('/reports/new');
            },
          ),
        ],
      ),
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
