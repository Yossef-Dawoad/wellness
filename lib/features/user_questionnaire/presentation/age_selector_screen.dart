import 'package:flutter/material.dart';
import 'package:wellness/features/user_questionnaire/presentation/weight_scale_selector_screen.dart';

import '../../../core/common/services/local_database/shared_pref/shared_pref_helper.dart'
    show SharedPrefHelper;
import '../../../core/service_locator/sl.dart';
import '../data/user_questionaire_keys.dart';

class AgePickerScreen extends StatefulWidget {
  @override
  _AgePickerScreenState createState() => _AgePickerScreenState();
}

class _AgePickerScreenState extends State<AgePickerScreen> {
  final FixedExtentScrollController _scrollController = FixedExtentScrollController(
    initialItem: 29,
  );
  final List<int> ageList = List.generate(100, (index) => index + 1);
  int selectedIndex = 29;

  void _onContinue() async {
    int selectedAge = ageList[selectedIndex];
    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(SnackBar(content: Text('تم اختيار العمر: $selectedAge')));
    await sl<SharedPrefHelper>().setValue<int>(UserQuestionaireKeys.age, selectedAge);
    if (mounted) // Check if the widget is being built
      Navigator.push(context, MaterialPageRoute(builder: (context) => WeightScalePage()));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 90),
          Text('Your age', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            'Age information helps us more accurately\nassess your metabolic level',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          SizedBox(height: 40),

          // عنصر منتصف الشاشة
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // الخلفية الرمادية الجميلة مع padding و borderRadius كبير
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),

                  // الرقم + كلمة years old
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 150,
                        child: ListWheelScrollView.useDelegate(
                          controller: _scrollController,
                          itemExtent: 50,
                          perspective: 0.002,
                          diameterRatio: 1.2,
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: ageList.length,
                            builder: (context, index) {
                              bool isSelected = index == selectedIndex;
                              return Center(
                                child: Text(
                                  '${ageList[index]}',
                                  style: TextStyle(
                                    fontSize: isSelected ? 24 : 20,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected ? Colors.black : Colors.grey,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text('years old', style: TextStyle(fontSize: 24, color: Colors.black)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              onPressed: _onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('CONTINUE', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
