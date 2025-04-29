import 'package:flutter/material.dart';
import 'package:wellness/features/user_questionnaire/presentation/components/gender_types_listview.dart';
import 'package:wellness/features/user_questionnaire/presentation/goal_selector_screen.dart';

import 'components/bottom_navigation_btns.dart';

class GenderTypeSelectorScreen extends StatefulWidget {
  const GenderTypeSelectorScreen({super.key});

  @override
  State<GenderTypeSelectorScreen> createState() =>
      _GenderTypeSelectorScreenState();
}

class _GenderTypeSelectorScreenState extends State<GenderTypeSelectorScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 12.0),
              Text(
                'Tell us your\ngender?',
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20.0),
              const GenderTypesListView(),
              const SizedBox(height: 20.0),
              BottomNavigationButtons(
                onNextPressed:
                    () => Navigator.push(
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
