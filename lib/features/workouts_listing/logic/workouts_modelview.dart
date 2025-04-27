import 'package:flutter/widgets.dart';

class Workout {
  final String name;
  final Color boxColor;
  bool isSelected;

  Workout({required this.name, required this.boxColor, this.isSelected = false});
}

class WorkoutsModelView {
  final ValueNotifier<Set<Workout>> selectedWorkout = ValueNotifier({});

  final List<Workout> workouts = [
    Workout(name: 'Abs', boxColor: Color(0xFFFFF59B)),
    Workout(name: 'Shoulders', boxColor: Color(0xFFE1BEE7)),
    Workout(name: 'Neck', boxColor: Color(0xFFB3E5FC)),
    Workout(name: 'Hands', boxColor: Color(0xFFFFB097)),
    Workout(name: 'Arms', boxColor: Color(0xFFC8E6C9)),
    Workout(name: 'Chest', boxColor: Color(0xFFF8BBD0)),
    Workout(name: 'Back', boxColor: Color(0xFFF9FF83)),
    Workout(name: 'Stomach', boxColor: Color(0xFFB3E5FC)),
    Workout(name: 'Buttocks', boxColor: Color(0xFFC8E6C9)),
    Workout(name: 'Legs', boxColor: const Color(0xFFFF99F1)),
  ];

  WorkoutsModelView();

  void updateSelectedWorkouts(int exerciseIndex) {
    final workout = workouts[exerciseIndex]..isSelected = !workouts[exerciseIndex].isSelected;
    if (workout.isSelected) {
      selectedWorkout.value = {...selectedWorkout.value, workout};
    } else {
      selectedWorkout.value = {...selectedWorkout.value}..remove(workouts[exerciseIndex]);
    }
  }
}
