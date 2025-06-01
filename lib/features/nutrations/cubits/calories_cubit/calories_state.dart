abstract class CaloriesState {}

class CaloriesInitial extends CaloriesState {}

class CaloriesLoading extends CaloriesState {}

class CaloriesLoaded extends CaloriesState {
  final double calories;
  final double protein;
  final double carbs;
  final double fats;

  CaloriesLoaded({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  });
}

class CaloriesError extends CaloriesState {
  final String message;

  CaloriesError({required this.message});
}
