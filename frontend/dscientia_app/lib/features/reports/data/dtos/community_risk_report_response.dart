class CommunityRiskReportResponse {
  const CommunityRiskReportResponse({
    required this.id,
    required this.organizationName,
    required this.category,
    required this.location,
    required this.urgency,
    required this.description,
    required this.status,
    this.reporterName,
    this.affectedPeopleCount,
    this.sourceUrl,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String organizationName;
  final String? reporterName;
  final String category;
  final String location;
  final String urgency;
  final String description;
  final int? affectedPeopleCount;
  final String status;
  final String? sourceUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CommunityRiskReportResponse.fromJson(Map<String, dynamic> json) {
    return CommunityRiskReportResponse(
      id: json['id'] as int,
      organizationName: json['organization_name'] as String,
      reporterName: json['reporter_name'] as String?,
      category: json['category'] as String,
      location: json['location'] as String,
      urgency: json['urgency'] as String,
      description: json['description'] as String,
      affectedPeopleCount: json['affected_people_count'] as int?,
      status: json['status'] as String,
      sourceUrl: json['source_url'] as String?,
      createdAt: _parseDateTime(json['created_at']),
      updatedAt: _parseDateTime(json['updated_at']),
    );
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value is! String || value.isEmpty) {
      return null;
    }

    return DateTime.tryParse(value);
  }
}
