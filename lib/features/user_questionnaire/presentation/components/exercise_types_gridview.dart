import 'package:flutter/material.dart';

import '../../logic/exercise_questionnaire_modelview.dart';
import '../widgets/pill_shaped_btn.dart';

class ExerciseTypesGridView extends StatefulWidget {
  const ExerciseTypesGridView({super.key});

  @override
  State<ExerciseTypesGridView> createState() => _ExerciseTypesGridViewState();
}

class _ExerciseTypesGridViewState extends State<ExerciseTypesGridView> {
  final exerciseModelView = ExerciseQuestionnaireModelView();
  @override
  Widget build(BuildContext context) {
    final exerisesList = exerciseModelView.exercises;
    return Expanded(
      child: GridView.builder(
        itemCount: exerisesList.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 2.4,
        ),
        itemBuilder: (context, index) {
          // Pass the shared model to each button
          return PillShapeButton(
            exerciseIndex: index,
            modelView: exerciseModelView, // Pass the shared model
          );
        },
      ),
    );
  }
}
