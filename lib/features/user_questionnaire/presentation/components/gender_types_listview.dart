import 'package:flutter/material.dart';
import 'package:wellness/core/common/services/local_database/shared_pref/shared_pref_helper.dart';
import 'package:wellness/core/common/services/sheared_preference_database.dart';
import 'package:wellness/core/service_locator/sl.dart';
import 'package:wellness/features/user_questionnaire/data/user_questionaire_keys.dart';

import '../../data/gender_type_model.dart';

class GenderTypesListView extends StatefulWidget {
  const GenderTypesListView({super.key, required this.selectedGenderNotifer});
  final ValueNotifier<int> selectedGenderNotifer;

  @override
  State<GenderTypesListView> createState() => _GenderTypesListViewState();
}

class _GenderTypesListViewState extends State<GenderTypesListView> {
  final List<GenderTypeModel> genderSelector = [
    GenderTypeModel(genderType: 'Male', genderImage: 'assets/images/onboarding/male.png'),
    GenderTypeModel(genderType: 'Female', genderImage: 'assets/images/onboarding/female.png'),
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genderSelector.length,
        itemBuilder: (ctx, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () async {
              widget.selectedGenderNotifer.value = index;
              setState(() {
                selectedIndex = index;
              });
              await sl<SharedPrefHelper>().setValue<String>(
                UserQuestionaireKeys.gender,
                genderSelector[index].genderType,
              );
            },
            child: Container(
              width: screenWidth * 0.4,

              margin: EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.white60,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isSelected ? Colors.blue : Colors.transparent, width: 2),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.asset(
                        genderSelector[index].genderImage,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        genderSelector[index].genderType,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
