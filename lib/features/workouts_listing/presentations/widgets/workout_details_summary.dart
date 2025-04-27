import 'package:flutter/material.dart';

import 'workout_details_card.dart';

class WorkoutsDetailsSummary extends StatelessWidget {
  const WorkoutsDetailsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        spacing: 4.0,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WorkoutDetailCard(icon: Icons.local_fire_department_outlined, label: '450 kcal'),
          WorkoutDetailCard(icon: Icons.timer_outlined, label: '45 min', applyGradient: true),
          WorkoutDetailCard(icon: Icons.fitness_center, label: '7'),
        ],
      ),
    );
  }
}
