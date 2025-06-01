class RoutineResponse {
  final int? count;
  final String? next;
  final String? previous;
  final List<RoutineData>? result;

  RoutineResponse({this.count, this.next, this.previous, this.result});

  factory RoutineResponse.fromJson(Map<String, dynamic> json) {
    return RoutineResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      result:
          (json['result'] as List<dynamic>?)
              ?.map((e) => RoutineData.fromJson(e))
              .toList(),
    );
  }
}

class RoutineData {
  final int? id;
  final String? name;
  final String? description;
  final String? created;
  final String? start;
  final String? end;
  final bool? fitInWeek;
  final bool? isTemplate;
  final bool? isPublic;

  RoutineData({
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

  factory RoutineData.fromJson(Map<String, dynamic> json) {
    return RoutineData(
      id: json['id'],
      name: json['name'],
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
