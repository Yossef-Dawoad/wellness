import 'package:flutter/material.dart';

class GoalListview extends StatefulWidget {
  const GoalListview({super.key});

  @override
  State<GoalListview> createState() => _GoalListviewState();
}

class _GoalListviewState extends State<GoalListview> {

  final List<String> goalsSentence = [
    'LOSE WEIGHT',
    'GET TONED',
    'BUILD MUSCLE',
  ];

  int? selectedGoalIndex;

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Expanded(
      child: ListView.separated(
        itemCount: goalsSentence.length,
        separatorBuilder:
            (context, index) => SizedBox(height: screenHeight * 0.03),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedGoalIndex = index;
              });
            },
            child: Container(
              height: screenHeight * 0.07,
              decoration: BoxDecoration(
                color:
                    selectedGoalIndex == index ? Colors.white70 : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color:
                      selectedGoalIndex == index ? Colors.green : Colors.white,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  goalsSentence[index],
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color:
                        selectedGoalIndex == index
                            ? Colors.green
                            : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
