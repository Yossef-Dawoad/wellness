import 'package:flutter/material.dart';
import 'package:wellness/features/workouts_listing/presentations/dashboard_screen.dart';

import 'components/bottom_navigation_btns.dart';
import 'components/exercise_types_gridview.dart';
import 'favorites_meals_selector_screen.dart';

class ExerciseTypeSelectorPage extends StatefulWidget {
  const ExerciseTypeSelectorPage({super.key});

  @override
  State<ExerciseTypeSelectorPage> createState() => _ExerciseTypeSelectorPageState();
}

class _ExerciseTypeSelectorPageState extends State<ExerciseTypeSelectorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 12.0),
              const Text(
                'what do you want\n to work on?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w900, color: Colors.black),
              ),
              const SizedBox(height: 20.0),
              ExerciseTypesGridView(),
              const SizedBox(height: 10.0),
              const Text(
                "It's time to choose what meals to get your nutrations up the rooof.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0, color: Colors.black54),
              ),
              const SizedBox(height: 40.0),
              // Navigation buttons
              BottomNavigationButtons(
                onNextPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainHomeScreen()),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
