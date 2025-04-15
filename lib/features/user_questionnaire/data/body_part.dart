import 'dart:ui';

import 'package:flutter/material.dart';

class BodyPart{
  final String partName;
  bool isSelected ;
  Color? boxColor;

  BodyPart({required this.partName,this.isSelected = false,required this.boxColor});
}
