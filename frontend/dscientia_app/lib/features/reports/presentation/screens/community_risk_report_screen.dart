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

    return Scaffold(
      appBar: AppBar(title: const Text('Community Risk Report')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.assignment_outlined,
                          color: colorScheme.onPrimaryContainer,
                          size: 40,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Submit Community Risk Report',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          backendModeEnabled
                              ? 'Backend mode is enabled. This report will be sent to the Laravel API before generating an AI insight.'
                              : 'Capture a local issue so DscienTia can prepare an AI-powered resilience insight in the next MVP step.',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: colorScheme.onPrimaryContainer),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (_submitError != null) ...[
                  Card(
                    color: colorScheme.errorContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        _submitError!,
                        style: TextStyle(color: colorScheme.onErrorContainer),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
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
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
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
                const SizedBox(height: 24),
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
                const SizedBox(height: 12),
                Text(
                  backendModeEnabled
                      ? 'MVP note: backend mode is active for local API testing. The public web demo can remain in local mock mode.'
                      : 'MVP note: this form currently uses local mock behavior. Backend persistence can be enabled with DSCIENTIA_USE_BACKEND_API=true.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
