import 'package:flutter/material.dart';
import 'package:wellness/features/user_questionnaire/data/user_questionaire_keys.dart';
import '../../../../core/common/services/local_database/shared_pref/shared_pref_helper.dart';
import '../../../../core/service_locator/sl.dart';

import 'bmi_calculator.dart';

class BMiContainer extends StatefulWidget {
  const BMiContainer({super.key});

  @override
  State<BMiContainer> createState() => _BMiContainerState();
}

class _BMiContainerState extends State<BMiContainer> {
  // Default values
  int weight = 60;
  double height = 172;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Load data after widget is initialized
    _loadUserData();
  }

  // Method to load data from SharedPreferences
  Future<void> _loadUserData() async {
    try {
      final sharedPrefHelper = sl<SharedPrefHelper>();

      // Get height from SharedPreferences
      final savedHeight = await sharedPrefHelper.getValue<double>(UserQuestionaireKeys.height);
      if (savedHeight != null) {
        height = savedHeight;
      }

      // Get weight from SharedPreferences
      final savedWeight = await sharedPrefHelper.getValue<int>(UserQuestionaireKeys.weight);
      if (savedWeight != null) {
        print(savedWeight);
        weight = savedWeight;
      }

      // Only update state if the widget is still mounted
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle errors
      print('Error loading user data: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while data is being fetched
    if (_isLoading) {
      return Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
        ),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    // Calculate BMI once data is loaded
    final bmiCategory = calculateBmiCategory(weight.toDouble(), height);
    double heightInMeters = height / 100;
    double bmiValue = weight / (heightInMeters * heightInMeters);

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('BMI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    bmiValue.toStringAsFixed(1),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(color: bmiCategory.color, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    bmiCategory.label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: bmiCategory.color,
                    ),
                  ),
                ],
              ),
              Text(bmiCategory.message, style: TextStyle(fontSize: 12, color: Colors.black87)),
            ],
          ),
        ],
      ),
    );
  }
}
