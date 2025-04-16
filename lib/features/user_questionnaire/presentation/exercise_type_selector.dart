import 'dart:math';
import 'package:flutter/material.dart';

import '../data/body_part.dart';
import 'favorites_page.dart';

class BodyPartsPage extends StatefulWidget {
  const BodyPartsPage({super.key});

  @override
  State<BodyPartsPage> createState() => _BodyPartsPageState();
}

class _BodyPartsPageState extends State<BodyPartsPage> {
  final List<BodyPart> bodyParts = [
    BodyPart(partName: 'Abs', boxColor: Colors.grey[300]),
    BodyPart(partName: 'Shoulders', boxColor: Colors.grey[300]),
    BodyPart(partName: 'Neck', boxColor: Colors.grey[300]),
    BodyPart(partName: 'Hands', boxColor: Colors.grey[300]),
    BodyPart(partName: 'Arms', boxColor: Colors.grey[300]),
    BodyPart(partName: 'Chest', boxColor: Colors.grey[300]),
    BodyPart(partName: 'Back', boxColor: Colors.grey[300]),
    BodyPart(partName: 'Stomach', boxColor: Colors.grey[300]),
    BodyPart(partName: 'Buttocks', boxColor: Colors.grey[300]),
    BodyPart(partName: 'Legs', boxColor: Colors.grey[300]),
  ];

  final List<String> selectedParts = [];

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  void selection(BodyPart part) {
    setState(() {
      part.isSelected = !part.isSelected;
      if (part.isSelected) {
        part.boxColor = getRandomColor();
        selectedParts.add(part.partName);
      } else {
        part.boxColor = Colors.grey[300];
        selectedParts.remove(part.partName);
      }
    });
  }

  Widget buildBodyPartButton(BodyPart part) {
    return SizedBox(
      height: 60.0,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: part.boxColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        onPressed: () => selection(part),
        child: Text(
          part.partName,
          style: const TextStyle(fontSize: 18.0, color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  'what do you want to work on?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: GridView.builder(
                    itemCount: bodyParts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 3.5,
                        ),
                    itemBuilder: (context, index) {
                      return buildBodyPartButton(bodyParts[index]);
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  "It's time to choose what part of body you want to improve.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.0, color: Colors.black54),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 70.0,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
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
                                  ? () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FavoritesPage(),
                                    ),
                                  )
                                  : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                selectedParts.isNotEmpty
                                    ? Colors.lightBlue
                                    : Colors.grey,
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
