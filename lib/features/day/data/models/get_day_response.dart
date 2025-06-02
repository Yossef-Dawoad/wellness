class GetDayResponse {
  final int? count;
  final String? next;
  final String? previous;
  final List<GetDayData>? result;

  GetDayResponse({this.count, this.next, this.previous, this.result});

  factory GetDayResponse.fromJson(Map<String, dynamic> json) {
    return GetDayResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      result:
          (json['result'] as List<dynamic>?)
              ?.map((e) => GetDayData.fromJson(e))
              .toList(),
    );
  }
}


class GetDayData {
  final int? id;
  final int? routineID;
  final int? order;
  final String? name;
  final String? description;
  final String? type;
  final Map<String, dynamic>? config;
  final bool? isRest;
  final bool? needLogsToAdvance;

  GetDayData( {
    this.id,
    this.name,
    this.description,
    this.routineID, this.order, this.type, this.config, this.isRest, this.needLogsToAdvance, 
  });

  factory GetDayData.fromJson(Map<String, dynamic> json) {
    return GetDayData(
      id: json['id'],
      routineID: json['routine'],
      name: json['name'],
      description: json['description'],
      order: json['order'],
      isRest: json['is_rest'],
      needLogsToAdvance: json['need_logs_to_advance'],
      type: json['type'],
      config: json['config'] ?? {},
    );
  }
}

