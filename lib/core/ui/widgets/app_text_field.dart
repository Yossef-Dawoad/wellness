import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color_palette.dart';
import '../text_styles.dart';

class AppTextField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final TextStyle? inputTextSyle;
  final TextStyle? hintStyle;
  final String hintText;
  final Color? backGroundColor;
  final Widget? prefixIcon;
  final Function()? onTap;
  final TextEditingController? controller;
  final bool? readOnly;
  // final TextEditingController? controller;
  const AppTextField({
    super.key,
    this.contentPadding,
    this.enabledBorder,
    this.focusedBorder,
    this.inputTextSyle,
    this.hintStyle,
    required this.hintText,
    this.backGroundColor,
    this.errorBorder,
    this.focusedErrorBorder,
    this.prefixIcon,
    this.onTap, this.controller, this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyles.body,
      readOnly: readOnly ?? false,
      onTap: onTap,
      decoration: InputDecoration(
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(width: 1.3, color: Palette.textPrimary),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(width: 1.3, color: Palette.textLight),
            ),
        hintStyle:
            hintStyle ?? TextStyles.body.copyWith(color: Color(0xFFC2C2C2)),
        hintText: hintText,
        fillColor: backGroundColor ?? Color(0xfffdfdff),
        filled: true,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
