import 'package:flutter/material.dart';
import 'package:wellness/features/user_questionnaire/data/user_questionaire_keys.dart';

import '../../../../core/service_locator/sl.dart';

class GoalListview extends StatefulWidget {
  final ValueNotifier<int?> selectedGoalNotifier;

  const GoalListview({super.key, required this.selectedGoalNotifier});

  @override
  State<GoalListview> createState() => _GoalListviewState();
}

class _GoalListviewState extends State<GoalListview> {
  final List<String> goalsSentence = ['LOSE WEIGHT', 'GET TONED', 'BUILD MUSCLE'];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Expanded(
      child: ValueListenableBuilder<int?>(
        valueListenable: widget.selectedGoalNotifier,
        builder: (context, selectedIndex, _) {
          return ListView.separated(
            itemCount: goalsSentence.length,
            separatorBuilder: (context, index) => SizedBox(height: screenHeight * 0.03),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Update the ValueNotifier when a goal is selected
                  widget.selectedGoalNotifier.value = index;
                },
                child: Container(
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                    color: selectedIndex == index ? Colors.white70 : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: selectedIndex == index ? Colors.green : Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      goalsSentence[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
