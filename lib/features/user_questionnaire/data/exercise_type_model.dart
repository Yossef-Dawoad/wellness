import 'dart:ui';

import 'package:flutter/material.dart';

class ExerciseType {
  final String name;
  bool isSelected;
  Color? boxColor;

  ExerciseType({required this.name, required this.boxColor, this.isSelected = false});

  @override
  String toString() {
    return 'name: $name, isSelected: $isSelected';
  }
}
