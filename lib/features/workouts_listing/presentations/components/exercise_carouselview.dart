import 'package:flutter/material.dart';

import '../exercise_by_type.dart';
import '../widgets/exercies_card.dart';

class ExerciseCardsCarouselView extends StatelessWidget {
  const ExerciseCardsCarouselView({super.key});
  // Calculate the card width based on screen width

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final cardWidth = screenWidth - 32; //
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List<Widget>.generate(10, (int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExerciseByTypeScreen()),
            );
          },
          child: Container(
            width: cardWidth * 0.9,
            margin: EdgeInsets.only(right: 16),
            child: ExerciesCard(
              icon: Icons.bolt,
              title: 'Full Body',
              subTitle: 'Easy • 24min',
              description: 'Full body workout to get your heart rate up and burn calories.',
            ),
          ),
        );
      }),
    );
  }
}
