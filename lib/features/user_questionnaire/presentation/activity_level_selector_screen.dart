import 'package:flutter/material.dart';
import 'package:wellness/features/user_questionnaire/presentation/components/activity_level_listview.dart';
import 'package:wellness/features/user_questionnaire/presentation/weight_scale_selector_screen.dart';
//import '../../../core/common/services/sheared_preference_database.dart';
import 'age_selector_screen.dart' show AgePickerScreen;
import 'components/bottom_navigation_btns.dart';
import 'goal_selector_screen.dart';

class ActivityLevelSelectorScreen extends StatefulWidget {
  const ActivityLevelSelectorScreen({super.key});

  @override
  State<ActivityLevelSelectorScreen> createState() => _GoalSelectorScreenState();
}

class _GoalSelectorScreenState extends State<ActivityLevelSelectorScreen> {
  final ValueNotifier<int> _selectedNotifier = ValueNotifier<int>(0);

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
                "How often would you\nlike to work out?",
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 100),
              // Activity List
              ActivityLevelListview(selectedIndexNotifier: _selectedNotifier),
              BottomNavigationButtons(
                onNextPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AgePickerScreen()),
                    ),
                onBackPressed:
                    () => Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => GoalSelectorScreen()),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
