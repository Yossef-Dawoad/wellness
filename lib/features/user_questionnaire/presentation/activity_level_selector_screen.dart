import 'package:flutter/material.dart';
import 'package:wellness/features/user_questionnaire/presentation/components/activity_level_listview.dart';
//import '../../../core/common/services/sheared_preference_database.dart';
import 'components/bottom_navigation_btns.dart';
import 'goal_selector_screen.dart';

class ActivityLevelSelectorScreen extends StatefulWidget {
  const ActivityLevelSelectorScreen({super.key});

  @override
  State<ActivityLevelSelectorScreen> createState() => _GoalSelectorScreenState();
}

class _GoalSelectorScreenState extends State<ActivityLevelSelectorScreen> {

  //test local database (shearedPreference)
  // Future<void> some() async {
  //   String? g = await GenderDataBaseShearedPreference.getGenderType('activitySelected');
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
                "How often would you\nlike to work out?",
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 60),
              // Activity List
              ActivityLevelListview(),
              BottomNavigationButtons(
                // onNextPressed: () => some(),
                // onNextPressed:
                //     () => Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => GoalSelectorScreen()),
                // ),
                onBackPressed:
                    () => Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoalSelectorScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
