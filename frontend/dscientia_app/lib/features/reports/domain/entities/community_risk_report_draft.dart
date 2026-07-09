class CommunityRiskReportDraft {
  final String title;
  final String category;
  final String location;
  final String description;
  final String urgency;

  const CommunityRiskReportDraft({
    required this.title,
    required this.category,
    required this.location,
    required this.description,
    required this.urgency,
  });

  const CommunityRiskReportDraft.demo()
    : title = 'Flooding near community road',
      category = 'Flooding',
      location = 'RT 07 RW 01, Magelang',
      description =
          'Residents reported recurring flooding near the main community road after heavy rain. The issue may affect mobility, safety, and access to essential services.',
      urgency = 'High';
}
