import 'package:flutter/material.dart';
import 'package:wellness/core/common/services/local_database/shared_pref/shared_pref_helper.dart';
//import 'package:wellness/core/common/services/sheared_preference_database.dart';
import 'package:wellness/features/user_questionnaire/presentation/components/gender_types_listview.dart';
import 'package:wellness/features/user_questionnaire/presentation/goal_selector_screen.dart';

import '../../../core/service_locator/sl.dart';
import '../data/user_questionaire_keys.dart';
import 'components/bottom_navigation_btns.dart';

class GenderTypeSelectorScreen extends StatefulWidget {
  const GenderTypeSelectorScreen({super.key});

  @override
  State<GenderTypeSelectorScreen> createState() => _GenderTypeSelectorScreenState();
}

class _GenderTypeSelectorScreenState extends State<GenderTypeSelectorScreen> {
  final ValueNotifier<int> selectedGenderNotifer = ValueNotifier<int>(0);
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
              GenderTypesListView(selectedGenderNotifer: selectedGenderNotifer),
              const SizedBox(height: 20.0),
              BottomNavigationButtons(
                onNextPressed: () async {
                  await sl<SharedPrefHelper>().setValue<int>(
                    UserQuestionaireKeys.gender,
                    selectedGenderNotifer.value,
                  );
                  if (mounted)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GoalSelectorScreen()),
                    );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
