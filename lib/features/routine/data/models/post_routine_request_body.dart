class PostRoutineRequestBody {
  final String name;
  final String? description;
  final String? start;
  final String? end;
  final bool? fitInWeek;
  final bool? isTemplate;
  final bool isPublic = false; // ثابتة على false

  PostRoutineRequestBody({
    required this.name,
    this.description,
    this.start,
    this.end,
    this.fitInWeek,
    this.isTemplate,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'start': start,
      'end': end,
      'fit_in_week': fitInWeek,
      'is_template': isTemplate,
    };
  }
}
