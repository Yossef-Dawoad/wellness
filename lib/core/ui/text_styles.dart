// Text Styles based on the design system

// import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wellness/core/ui/color_palette.dart';

class TextStyles {
  static  TextStyle heading1 = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: Palette.textPrimary,
    height: 1.3,
  );

  static TextStyle heading2 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: Palette.textPrimary,
    height: 1.3.h,
  );

  static TextStyle heading3 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: Palette.textPrimary,
    height: 1.3.h,
  );

  static TextStyle subtitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Palette.textSecondary,
    height: 1.5.h,
  );

  static TextStyle body = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Palette.textPrimary,
    height: 1.5.h,
  );

  static TextStyle caption = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: Palette.textLight,
    height: 1.5.h,
  );
}
