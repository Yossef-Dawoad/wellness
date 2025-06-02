
class PostDayResponse {
  final int? id;
  final int? routineID;
  final int? order;
  final String? name;
  final String? description;
  final String? type;
  final Map<String, dynamic>? config;
  final bool? isRest;
  final bool? needLogsToAdvance;

  PostDayResponse({
    this.id,
    this.routineID,
    this.order,
    this.name,
    this.description,
    this.type,
    this.config,
    this.isRest,
    this.needLogsToAdvance,
  });

  factory PostDayResponse.fromJson(Map<String, dynamic> json) {
    return PostDayResponse(
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
