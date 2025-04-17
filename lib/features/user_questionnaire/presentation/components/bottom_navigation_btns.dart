import 'package:flutter/material.dart';

class BottomNavigationButtons extends StatelessWidget {
  const BottomNavigationButtons({super.key, this.onBackPressed, this.onNextPressed, this.label});
  final VoidCallback? onBackPressed;
  final VoidCallback? onNextPressed;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onBackPressed ?? Navigator.of(context).pop,
          child: Text('Back', style: TextStyle(color: Colors.grey[400], fontSize: 16.0)),
        ),
        ElevatedButton(
          // Handle next navigation
          onPressed: onNextPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          ),
          child: Text(
            label ?? 'Next',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
