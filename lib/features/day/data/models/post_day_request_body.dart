class PostDayRequestBody {
  final int routineID;
  final int order;
  final String name;
  final String description;
  final bool isRest;
  final bool needLogsToAdvance;
  final String type = 'custom';
  final Map<String, dynamic> config;

  PostDayRequestBody({
    required this.routineID,
    required this.order,
    required this.name,
    required this.description,
    required this.isRest,
    required this.needLogsToAdvance,
    required this.config,
  });

  Map<String, dynamic> toJson() {
    return {
      'routine': routineID,
      'order': order,
      'name': name,
      'description': description,
      'is_rest': isRest,
      'need_logs_to_advance': needLogsToAdvance,
      'config': config,
      'type': type,
    };
  }
}
