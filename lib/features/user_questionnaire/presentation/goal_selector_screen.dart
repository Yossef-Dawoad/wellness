import 'package:flutter/material.dart';
import 'package:wellness/core/common/services/local_database/shared_pref/shared_pref_helper.dart';
import 'package:wellness/features/user_questionnaire/data/user_questionaire_keys.dart';
import 'package:wellness/features/user_questionnaire/presentation/activity_level_selector_screen.dart';
import 'package:wellness/features/user_questionnaire/presentation/components/goal_listview.dart';
import 'package:wellness/features/user_questionnaire/presentation/gender_type_selector_screen.dart';

//import '../../../core/common/services/sheared_preference_database.dart';
import '../../../core/service_locator/sl.dart';
import 'components/bottom_navigation_btns.dart';

class GoalSelectorScreen extends StatefulWidget {
  const GoalSelectorScreen({super.key});

  @override
  State<GoalSelectorScreen> createState() => _GoalSelectorScreenState();
}

class _GoalSelectorScreenState extends State<GoalSelectorScreen> {
  final ValueNotifier<int> selectedGoalNotifier = ValueNotifier<int>(0);

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
              GoalListview(selectedGoalNotifier: selectedGoalNotifier),
              // Spacer(),
              BottomNavigationButtons(
                onNextPressed: () {
                  sl<SharedPrefHelper>().setValue<int>(
                    UserQuestionaireKeys.goal,
                    selectedGoalNotifier.value,
                  );
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
