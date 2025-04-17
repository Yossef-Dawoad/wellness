import 'package:flutter/widgets.dart';

class Palette {
  // Primary Colors
  static const Color teal500 = Color(0xFF4FD1C5);
  static const Color teal600 = Color(0xFF38B2AC);

  // Secondary Colors
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color green500 = Color(0xFF10B981);
  static const Color purple500 = Color(0xFF8B5CF6);
  static const Color red500 = Color(0xFFEF4444);

  // Background Colors
  static const Color background = Color(0xFFF5F7FA);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF8FAFC);

  // Text Colors
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);

  // Gradient Definitions
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFA6E3E9), Color(0xFF71C9CE)],
  );

  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6DD5ED), Color(0xFF2193B0)],
  );

  static const LinearGradient pinkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
  );

  static const LinearGradient purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5EE7DF), Color(0xFFB490CA)],
  );

  static const LinearGradient peachGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFAD0C4), Color(0xFFFFD1FF)],
  );

  static const LinearGradient progressGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF4FD1C5), Color(0xFF38B2AC)],
  );
}
