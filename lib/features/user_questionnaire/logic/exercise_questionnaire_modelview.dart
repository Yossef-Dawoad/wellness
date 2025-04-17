import 'package:flutter/widgets.dart';

import '../data/exercise_type_model.dart';

class ExerciseQuestionnaireModelView {
  final ValueNotifier<Color> randomColor = ValueNotifier(Color(0xFFF7F7F7));
  final ValueNotifier<Set<ExerciseType>> selectedExercises = ValueNotifier({});

  final List<ExerciseType> exercises = [
    ExerciseType(name: 'Abs', boxColor: Color(0xFFFFF59B)),
    ExerciseType(name: 'Shoulders', boxColor: Color(0xFFE1BEE7)),
    ExerciseType(name: 'Neck', boxColor: Color(0xFFB3E5FC)),
    ExerciseType(name: 'Hands', boxColor: Color(0xFFFFB097)),
    ExerciseType(name: 'Arms', boxColor: Color(0xFFC8E6C9)),
    ExerciseType(name: 'Chest', boxColor: Color(0xFFF8BBD0)),
    ExerciseType(name: 'Back', boxColor: Color(0xFFF9FF83)),
    ExerciseType(name: 'Stomach', boxColor: Color(0xFFB3E5FC)),
    ExerciseType(name: 'Buttocks', boxColor: Color(0xFFC8E6C9)),
    ExerciseType(name: 'Legs', boxColor: const Color(0xFFFF99F1)),
  ];

  ExerciseQuestionnaireModelView();

  void updateSelectedExercises(int exerciseIndex) {
    final exercise = exercises[exerciseIndex]..isSelected = !exercises[exerciseIndex].isSelected;
    if (exercise.isSelected) {
      selectedExercises.value = {...selectedExercises.value, exercise};
    } else {
      selectedExercises.value = {...selectedExercises.value}..remove(exercises[exerciseIndex]);
    }
  }
}
