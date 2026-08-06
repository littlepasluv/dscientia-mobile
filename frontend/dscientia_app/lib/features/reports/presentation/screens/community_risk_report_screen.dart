import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/env/backend_mode_config.dart';
import '../../../../config/env/dscientia_api_config.dart';
import '../../../../core/network/dscientia_api_dio_provider.dart';
import '../../../ai_insight/data/datasources/ai_insight_api_client.dart';
import '../../../ai_insight/data/dtos/ai_insight_create_request.dart';
import '../../../ai_insight/presentation/navigation/ai_insight_result_route_data.dart';
import '../../data/datasources/community_risk_report_api_client.dart';
import '../../data/dtos/community_risk_report_create_request.dart';
import '../../domain/entities/community_risk_report_draft.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/widgets/app_hero_card.dart';
import '../../../../shared/widgets/app_page_shell.dart';
import '../../../../shared/widgets/app_section_header.dart';
import '../../../../shared/widgets/app_status_badge.dart';

class CommunityRiskReportScreen extends ConsumerStatefulWidget {
  const CommunityRiskReportScreen({super.key});

  @override
  ConsumerState<CommunityRiskReportScreen> createState() =>
      _CommunityRiskReportScreenState();
}

class _CommunityRiskReportScreenState
    extends ConsumerState<CommunityRiskReportScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _affectedPeopleController = TextEditingController();

  String _selectedCategory = _categories.first;
  String _selectedUrgency = _urgencyLevels[1];
  bool _isSubmitting = false;
  String? _submitError;

  static const List<String> _categories = [
    'Flooding',
    'Public Safety',
    'Health Risk',
    'Infrastructure',
    'Environment',
    'Community Needs',
    'Other',
  ];

  static const List<String> _urgencyLevels = ['Low', 'Medium', 'High'];

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _affectedPeopleController.dispose();
    super.dispose();
  }

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final report = CommunityRiskReportDraft(
      title: _titleController.text.trim(),
      category: _selectedCategory,
      location: _locationController.text.trim(),
      description: _descriptionController.text.trim(),
      urgency: _selectedUrgency,
    );

    if (!BackendModeConfig.useBackendApi) {
      context.push('/ai-insights/result', extra: report);
      return;
    }

    setState(() {
      _isSubmitting = true;
      _submitError = null;
    });

    try {
      final dio = ref.read(dscientiaApiDioProvider);
      final reportClient = CommunityRiskReportApiClient(dio);
      final aiInsightClient = AiInsightApiClient(dio);

      final createdReport = await reportClient.createReport(
        CommunityRiskReportCreateRequest(
          organizationName: report.title,
          reporterName: 'DscienTia Flutter MVP',
          category: _toApiCategory(report.category),
          location: report.location,
          urgency: _toApiUrgency(report.urgency),
          description: report.description,
          affectedPeopleCount: _parseAffectedPeopleCount(),
          sourceUrl: 'https://app.dscientia.dev',
        ),
      );

      final backendInsight = await aiInsightClient.generateInsight(
        AiInsightCreateRequest(reportId: createdReport.id),
      );

      if (!mounted) {
        return;
      }

      context.push(
        '/ai-insights/result',
        extra: AiInsightResultRouteData(
          report: report,
          backendInsight: backendInsight,
        ),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _submitError =
            'Unable to connect to DscienTia API. Make sure Laravel is running at ${DscientiaApiConfig.baseUrl}.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  String _toApiCategory(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');
  }

  String _toApiUrgency(String value) {
    return value.trim().toLowerCase();
  }

  int? _parseAffectedPeopleCount() {
    final value = _affectedPeopleController.text.trim();

    if (value.isEmpty) {
      return null;
    }

    return int.tryParse(value);
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }

    return null;
  }

  String? _descriptionValidator(String? value) {
    final requiredError = _requiredValidator(value);

    if (requiredError != null) {
      return requiredError;
    }

    if (value!.trim().length < 20) {
      return 'Please provide at least 20 characters.';
    }

    return null;
  }

  String? _affectedPeopleValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final parsed = int.tryParse(value.trim());

    if (parsed == null || parsed < 0) {
      return 'Please enter a valid non-negative number.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backendModeEnabled = BackendModeConfig.useBackendApi;

    return AppPageShell(
      appBar: AppBar(title: const Text('Community Risk Report')),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppHeroCard(
              title: 'Submit Community Risk Report',
              description: backendModeEnabled
                  ? 'Backend mode is enabled. This report will be sent to the Laravel API before generating an AI insight.'
                  : 'Capture a local issue so DscienTia can prepare an AI-powered resilience insight in the next MVP step.',
              icon: Icons.assignment_outlined,
              trailing: AppStatusBadge(
                label: backendModeEnabled ? 'Backend API' : 'Local mock',
                tone: AppStatusTone.info,
                icon: backendModeEnabled
                    ? Icons.cloud_done_outlined
                    : Icons.science_outlined,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (_submitError != null) ...[
              Card(
                margin: EdgeInsets.zero,
                color: colorScheme.errorContainer,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Text(
                    _submitError!,
                    style: TextStyle(color: colorScheme.onErrorContainer),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
            const AppSectionHeader(
              title: 'Report details',
              description:
                  'Describe the issue and identify where it is happening.',
            ),
            _FormSectionCard(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Report title',
                    hintText: 'Example: Flooding near community road',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: _requiredValidator,
                ),
                const SizedBox(height: AppSpacing.md),
                DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  items: _categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    hintText: 'Example: RT 07 RW 01, Magelang',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: _requiredValidator,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            const AppSectionHeader(
              title: 'Impact and priority',
              description:
                  'Record the estimated impact and urgency of the issue.',
            ),
            _FormSectionCard(
              children: [
                TextFormField(
                  controller: _affectedPeopleController,
                  decoration: const InputDecoration(
                    labelText: 'Estimated affected people',
                    hintText: 'Example: 120',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: _affectedPeopleValidator,
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText:
                        'Describe what happened, who is affected, and what support may be needed.',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  minLines: 5,
                  maxLines: 8,
                  validator: _descriptionValidator,
                ),
                const SizedBox(height: AppSpacing.md),
                DropdownButtonFormField<String>(
                  initialValue: _selectedUrgency,
                  decoration: const InputDecoration(
                    labelText: 'Urgency level',
                    border: OutlineInputBorder(),
                  ),
                  items: _urgencyLevels.map((urgency) {
                    return DropdownMenuItem<String>(
                      value: urgency,
                      child: Text(urgency),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    setState(() {
                      _selectedUrgency = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: _isSubmitting ? null : _submitReport,
              icon: _isSubmitting
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.auto_awesome_outlined),
              label: Text(
                _isSubmitting ? 'Generating...' : 'Prepare AI Insight',
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              backendModeEnabled
                  ? 'MVP note: backend mode is active for local API testing. The public web demo can remain in local mock mode.'
                  : 'MVP note: this form currently uses local mock behavior. Backend persistence can be enabled with DSCIENTIA_USE_BACKEND_API=true.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _FormSectionCard extends StatelessWidget {
  const _FormSectionCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}
