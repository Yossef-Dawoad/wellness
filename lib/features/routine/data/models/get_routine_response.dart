class GetRoutineResponse {
  final int? count;
  final String? next;
  final String? previous;
  final List<GetRoutineData>? result;

  GetRoutineResponse({this.count, this.next, this.previous, this.result});

  factory GetRoutineResponse.fromJson(Map<String, dynamic> json) {
    return GetRoutineResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      result:
          (json['result'] as List<dynamic>?)
              ?.map((e) => GetRoutineData.fromJson(e))
              .toList(),
    );
  }
}

class GetRoutineData {
  final int? id;
  final String? name;
  final String? description;
  final String? created;
  final String? start;
  final String? end;
  final bool? fitInWeek;
  final bool? isTemplate;
  final bool? isPublic;

  GetRoutineData({
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

  factory GetRoutineData.fromJson(Map<String, dynamic> json) {
    return GetRoutineData(
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
