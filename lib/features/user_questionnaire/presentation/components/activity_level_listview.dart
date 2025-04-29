import 'package:flutter/material.dart';

import '../../../../core/common/services/sheared_preference_database.dart';

class ActivityLevelListview extends StatefulWidget {
  const ActivityLevelListview({super.key});

  @override
  State<ActivityLevelListview> createState() => _ActivityLevelListviewState();
}

class _ActivityLevelListviewState extends State<ActivityLevelListview> {
  final List<String> activityLevel = [
    'Hardly',
    '1-3 times a week',
    '3-5 times a week',
    'over 6 times a week',
  ];

  int? selectedActivityIndex;

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Expanded(
      child: ListView.separated(
        itemCount: activityLevel.length,
        separatorBuilder:
            (context, index) => SizedBox(height: screenHeight * 0.03),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              setState(() {
                selectedActivityIndex = index;
              });
              await GenderDataBaseShearedPreference.saveGenderType('activitySelected',activityLevel[index]);
            },
            child: Container(
              height: screenHeight * 0.07,
              decoration: BoxDecoration(
                color:
                selectedActivityIndex == index ? Colors.white70 : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color:
                  selectedActivityIndex == index ? Colors.green : Colors.white,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  activityLevel[index],
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color:
                    selectedActivityIndex == index
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
