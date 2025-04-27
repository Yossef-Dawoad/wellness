import 'package:flutter/material.dart';

class WorkoutDetailCard extends StatelessWidget {
  const WorkoutDetailCard({
    super.key,
    required this.label,
    required this.icon,
    this.applyGradient = false,
  });
  final String label;
  final IconData icon;
  final bool applyGradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 4),
          Text(
            label,
            style:
                !applyGradient
                    ? null
                    : TextStyle(
                      foreground:
                          Paint()
                            ..shader = LinearGradient(
                              colors: <Color>[Color(0xFF4480DA), Color.fromARGB(255, 238, 241, 18)],
                            ).createShader(Rect.fromLTWH(0.0, 0.0, 400.0, 70.0)),
                    ),
          ),
        ],
      ),
    );
  }
}
