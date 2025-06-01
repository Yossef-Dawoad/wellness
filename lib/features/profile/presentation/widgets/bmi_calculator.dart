import 'package:flutter/material.dart';
import '../../datasources/bmi_category_model.dart';

BmiCategory calculateBmiCategory(double weight, double heightCm) {
  double heightInMeters = heightCm / 100;
  double bmi = weight / (heightInMeters * heightInMeters);

  if (bmi <= 18.5) {
    return BmiCategory(
      label: 'Under Weight',
      color: Colors.blueAccent,
      message: 'You should gain some weight.',
    );
  } else if (bmi <= 24.9) {
    return BmiCategory(label: 'Normal', color: Colors.green, message: 'Perfect Weight.');
  } else if (bmi <= 29.9) {
    return BmiCategory(
      label: 'Over Weight',
      color: Colors.amber,
      message: 'You need to lose some weight.',
    );
  } else if (bmi <= 34.9) {
    return BmiCategory(
      label: 'Obesity',
      color: Colors.deepOrange,
      message: 'You need to lose weight.',
    );
  } else {
    return BmiCategory(
      label: 'Extremely Obese',
      color: Colors.redAccent,
      message: 'You must lose weight.',
    );
  }
}
