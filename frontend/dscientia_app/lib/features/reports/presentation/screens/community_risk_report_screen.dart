import 'package:go_router/go_router.dart';

import '../../domain/entities/community_risk_report_draft.dart';
import 'package:flutter/material.dart';

class CommunityRiskReportScreen extends StatefulWidget {
  const CommunityRiskReportScreen({super.key});

  @override
  State<CommunityRiskReportScreen> createState() =>
      _CommunityRiskReportScreenState();
}

class _CommunityRiskReportScreenState extends State<CommunityRiskReportScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategory = _categories.first;
  String _selectedUrgency = _urgencyLevels[1];

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
    super.dispose();
  }

  void _submitReport() {
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

    context.push('/ai-insights/result', extra: report);
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
                          'Capture a local issue so DscienTia can prepare an AI-powered resilience insight in the next MVP step.',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: colorScheme.onPrimaryContainer),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
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
                  validator: _requiredValidator,
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
                  onPressed: _submitReport,
                  icon: const Icon(Icons.auto_awesome_outlined),
                  label: const Text('Prepare AI Insight'),
                ),
                const SizedBox(height: 12),
                Text(
                  'MVP note: this form currently stores the report only in the UI flow. Backend persistence will be added in the Laravel API phase.',
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
