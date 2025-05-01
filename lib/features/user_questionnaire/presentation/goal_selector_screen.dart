import 'package:flutter/material.dart';
import 'package:wellness/features/user_questionnaire/presentation/activity_level_selector_screen.dart';
import 'package:wellness/features/user_questionnaire/presentation/components/goal_listview.dart';
import 'package:wellness/features/user_questionnaire/presentation/gender_type_selector_screen.dart';

//import '../../../core/common/services/sheared_preference_database.dart';
import 'components/bottom_navigation_btns.dart';

class GoalSelectorScreen extends StatefulWidget {
  const GoalSelectorScreen({super.key});

  @override
  State<GoalSelectorScreen> createState() => _GoalSelectorScreenState();
}

class _GoalSelectorScreenState extends State<GoalSelectorScreen> {
  //test local database (shearedPreference)
  // Future<void> some() async {
  //   String? g = await GenderDataBaseShearedPreference.getGenderType('goalSelected');
  //   if(g != null){
  //     print(g);
  //   }
  //   else{
  //     print('no data');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What's your\ngoal?",
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Achieve your goal with your personalized plan",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 80),

              // Goals List
              GoalListview(),
              // Spacer(),
              BottomNavigationButtons(
                onNextPressed: () {
                  //some();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ActivityLevelSelectorScreen()),
                  );
                },
                onBackPressed:
                    () => Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => GenderTypeSelectorScreen()),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
