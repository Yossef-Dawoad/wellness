import 'package:flutter/material.dart';

class StackedCircularAvatars extends StatelessWidget {
  const StackedCircularAvatars({
    super.key,
    required this.contents,
    this.avatarRadius = 30,
    this.overlapFactor = 0.5,
    this.trailing,
    this.border,
    this.backgroundColor = Colors.lightBlueAccent,
    this.contentCount = 3,
  });
  final double overlapFactor;
  final double avatarRadius;
  final List<Widget> contents;
  final int contentCount;
  final Color backgroundColor;
  final BoxBorder? border;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < contentCount; i++)
          Transform.translate(
            offset: Offset(-avatarRadius * 2 * overlapFactor * i, 0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: border ?? Border.all(color: Colors.white, width: 2),
              ),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: backgroundColor,
                child: contents[i],
              ),
            ),
          ),
        if (contents.length > contentCount)
          Transform.translate(
            offset: Offset(-avatarRadius * 2 * overlapFactor * contentCount, 0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.grey.shade200,
                child: Text(
                  '+${contents.length - contentCount}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        if (trailing != null)
          Transform.translate(
            // avatarRadius * 2 * overlapFactor * contents.length
            offset: Offset(-avatarRadius * 2 + avatarRadius, 0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.grey.shade200,
                child: trailing,
              ),
            ),
          ),
      ],
    );
  }
}
