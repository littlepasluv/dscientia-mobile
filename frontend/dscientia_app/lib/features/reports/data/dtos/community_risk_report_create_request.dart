class CommunityRiskReportCreateRequest {
  const CommunityRiskReportCreateRequest({
    required this.organizationName,
    required this.category,
    required this.location,
    required this.urgency,
    required this.description,
    this.reporterName,
    this.affectedPeopleCount,
    this.sourceUrl,
  });

  final String organizationName;
  final String? reporterName;
  final String category;
  final String location;
  final String urgency;
  final String description;
  final int? affectedPeopleCount;
  final String? sourceUrl;

  Map<String, dynamic> toJson() {
    return {
      'organization_name': organizationName,
      if (reporterName != null) 'reporter_name': reporterName,
      'category': category,
      'location': location,
      'urgency': urgency,
      'description': description,
      if (affectedPeopleCount != null)
        'affected_people_count': affectedPeopleCount,
      if (sourceUrl != null) 'source_url': sourceUrl,
    };
  }
}
