class PostRoutineResponse {
  final int? id;
  final String? name;
  final String? description;
  final String? created;
  final String? start;
  final String? end;
  final bool? fitInWeek;
  final bool? isTemplate;
  final bool? isPublic;

  PostRoutineResponse({
    this.id,
    this.name,
    this.description,
    this.created,
    this.start,
    this.end,
    this.fitInWeek,
    this.isTemplate,
    this.isPublic,
  });

  factory PostRoutineResponse.fromJson(Map<String, dynamic> json) {
    return PostRoutineResponse(
      id: json['id'],
      description: json['description'],
      created: json['created'],
      start: json['start'],
      end: json['end'],
      fitInWeek: json['fit_in_week'],
      isTemplate: json['is_template'],
      isPublic: json['is_public'],
    );
  }
}
