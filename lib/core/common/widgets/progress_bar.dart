import 'package:flutter/widgets.dart';
import 'package:wellness/core/ui/color_palette.dart';

class ProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double height;
  final LinearGradient? gradient;

  const ProgressBar({super.key, required this.progress, this.height = 8.0, this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: FractionallySizedBox(
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient ?? Palette.progressGradient,
            borderRadius: BorderRadius.circular(height / 2),
          ),
        ),
      ),
    );
  }
}
