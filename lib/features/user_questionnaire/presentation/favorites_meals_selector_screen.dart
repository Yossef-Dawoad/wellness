import 'package:flutter/material.dart';
import 'package:wellness/features/workouts_listing/presentations/dashboard_screen.dart';

import '../data/exercise_type_model.dart';

class FavoritesMealsSelectorPage extends StatefulWidget {
  const FavoritesMealsSelectorPage({super.key});

  @override
  State<FavoritesMealsSelectorPage> createState() => _FavoritesMealsSelectorPageState();
}

class _FavoritesMealsSelectorPageState extends State<FavoritesMealsSelectorPage> {
  final List<ExerciseType> favorites = [
    ExerciseType(name: 'Protein', boxColor: Colors.grey[300]),
    ExerciseType(name: 'Carbs', boxColor: Colors.grey[300]),
    ExerciseType(name: 'Fish', boxColor: Colors.grey[300]),
    ExerciseType(name: 'Dairy', boxColor: Colors.grey[300]),
    ExerciseType(name: 'Fruits', boxColor: Colors.grey[300]),
    ExerciseType(name: 'Vegetable', boxColor: Colors.grey[300]),
    ExerciseType(name: 'Organic', boxColor: Colors.grey[300]),
    ExerciseType(name: 'Caffe', boxColor: Colors.grey[300]),
    ExerciseType(name: 'Vegan', boxColor: Colors.grey[300]),
  ];

  final List<String> selectedParts = [];

  void selection(ExerciseType part) {
    setState(() {
      part.isSelected = !part.isSelected;
      if (part.isSelected) {
        part.boxColor = Colors.green;
        selectedParts.add(part.name);
      } else {
        part.boxColor = Colors.grey[300]!;
        selectedParts.remove(part.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 3.0, left: 10.0, right: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                const Text(
                  'What do you like most?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: GridView.builder(
                    itemCount: favorites.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final part = favorites[index];
                      return TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: part.boxColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                        ),
                        onPressed: () => selection(part),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.category, size: 30.0),
                            const SizedBox(height: 8.0),
                            Text(
                              part.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'This is used in getting, personalized results & plants for you',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 70.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                          child: const Text(
                            'Back',
                            style: TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: SizedBox(
                        height: 70.0,
                        child: ElevatedButton(
                          onPressed:
                              selectedParts.isNotEmpty
                                  ? () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => MainHomeScreen()),
                                    );
                                  }
                                  : null,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                          child: const Text(
                            'Next',
                            style: TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
