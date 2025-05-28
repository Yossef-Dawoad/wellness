import 'package:flutter/material.dart';

class Mealstext extends StatelessWidget {
  const Mealstext({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Text(
        'Meals',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
