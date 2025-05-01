import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CaloriesLeftInfo extends StatelessWidget {
  const CaloriesLeftInfo({
    super.key,
    required this.typeInfo,
    required this.num,
    required this.icon,
  });
  final String typeInfo;
  final double num;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Colors.grey,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 50),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        height: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              spacing: 2,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${num.toInt()}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(typeInfo, style: TextStyle(fontSize: 16)),
              ],
            ),
            Spacer(),
            CircularPercentIndicator(
              radius: 40,
              center: icon,
              percent: 1.0,
              progressColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
