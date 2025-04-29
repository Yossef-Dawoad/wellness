import 'package:flutter/material.dart';

import '../../data/gender_type_model.dart';

class GenderTypesListView extends StatefulWidget {
  const GenderTypesListView({super.key});

  @override
  State<GenderTypesListView> createState() => _GenderTypesListViewState();
}

class _GenderTypesListViewState extends State<GenderTypesListView> {
  final List<GenderTypeModel> genderSelector = [
    GenderTypeModel(
      genderType: 'Male',
      genderImage: 'assets/images/onboarding/male.png',
    ),
    GenderTypeModel(
      genderType: 'Female',
      genderImage: 'assets/images/onboarding/female.png',
    ),
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
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              width: screenWidth * 0.4,
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.white60,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
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
