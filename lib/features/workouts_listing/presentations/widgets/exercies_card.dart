import 'package:flutter/material.dart';

import '../../../../core/common/widgets/stacked_circular_avatar.dart' show StackedCircularAvatars;

class ExerciesCard extends StatelessWidget {
  const ExerciesCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.description,
    this.color = Colors.lightBlueAccent,
  });
  final IconData icon;
  final String title;
  final String subTitle;
  final String? description;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xC8BBDEFB), const Color(0x869ED2FD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFF9ED2FD),
                  radius: 28,
                  child: Icon(Icons.bolt),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(subTitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            if (description != null)
              Column(
                children: [
                  Text(description!, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                  SizedBox(height: 20),
                ],
              ),

            Expanded(
              child: StackedCircularAvatars(
                avatarRadius: 20,
                overlapFactor: 0.3,
                contentCount: 3,
                contents: [
                  Icon(Icons.timer, size: 20),
                  Icon(Icons.fitness_center, size: 20),
                  Icon(Icons.directions_run, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
