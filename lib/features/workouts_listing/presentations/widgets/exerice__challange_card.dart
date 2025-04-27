import 'package:flutter/material.dart';

import '../../../../core/common/widgets/stacked_circular_avatar.dart';

class ChallengeExericeCard extends StatelessWidget {
  const ChallengeExericeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: MediaQuery.sizeOf(context).width * 0.85,
      decoration: BoxDecoration(color: Color(0xFFE8FBF7), borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xFF93FFE8), Color.fromARGB(31, 203, 255, 244)],
                    ),
                    // color: Color(0xFF9ED2FD),
                  ),
                  width: 70,
                  height: 70,
                  child: Center(child: Icon(Icons.bolt)),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Full-Body', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('Easy.24min', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Full Body Workout to shift Stubborn body fast and build mucle',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            StackedCircularAvatars(
              avatarRadius: 25,
              overlapFactor: 0.3,
              contents: [
                Icon(Icons.person_3_sharp),
                Icon(Icons.person_3_sharp),
                Icon(Icons.person_3_sharp),
                Icon(Icons.person_3_sharp),
              ],
              trailing: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
