import 'package:flutter/material.dart';

import '../../logic/exercise_questionnaire_modelview.dart';

//TODO Abstract the button for common properties to be commonly used

class PillShapeButton extends StatefulWidget {
  const PillShapeButton({
    super.key,
    required this.exerciseIndex,
    required this.modelView, // Add this parameter
  });

  final int exerciseIndex;
  final ExerciseQuestionnaireModelView modelView; // Store the shared model

  @override
  State<PillShapeButton> createState() => _PillShapeButtonState();
}

class _PillShapeButtonState extends State<PillShapeButton> {
  late final ExerciseQuestionnaireModelView exercisesviewModel;
  final initialColor = Color(0xFFF7F7F7);

  @override
  void initState() {
    super.initState();
    exercisesviewModel = widget.modelView;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: exercisesviewModel.selectedExercises,
      builder: (context, exercises, child) {
        final exercise = exercisesviewModel.exercises[widget.exerciseIndex];
        return SizedBox(
          key: widget.key,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              // Use the exercise's own boxColor instead of the shared randomColor
              backgroundColor: exercise.isSelected ? exercise.boxColor : initialColor,
              elevation: 0.0,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            ),
            onPressed: () {
              exercisesviewModel.updateSelectedExercises(widget.exerciseIndex);
            },
            child: Text(
              exercise.name,
              style: const TextStyle(color: Colors.black, overflow: TextOverflow.ellipsis),
            ),
          ),
        );
      },
    );
  }
}
