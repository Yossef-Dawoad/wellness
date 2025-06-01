import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wellness/core/ui/color_palette.dart';

import '../text_styles.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final TextStyle? inputTextSyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObsecureText;
  final Widget? suffixIcon;
  final Color? backGroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;
  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.enabledBorder,
    this.focusedBorder,
    this.inputTextSyle,
    this.hintStyle,
    required this.hintText,
    this.isObsecureText,
    this.suffixIcon,
    this.backGroundColor,
    this.controller,
    required this.validator, this.errorBorder, this.focusedErrorBorder,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true, // use less vertical space
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                width: 1.3,
                color: Palette.textPrimary,
              ),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                width: 1.3,
                color: Palette.textLight,
              ),
            ),
        errorBorder:
            errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                width: 1.3,
                color: Colors.red,
              ),
            ),
        focusedErrorBorder:
            focusedErrorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                width: 1.3,
                color: Colors.red,
              ),
            ),
            
        hintStyle: hintStyle ?? TextStyles.body.copyWith(color: Color(0xFFC2C2C2)),
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: backGroundColor ?? Color(0xfffdfdff),
        filled: true,
      ),
      obscureText: isObsecureText ?? false,
      style: TextStyles.body,
      validator: (value) {
        return validator(value);
      },
    );
  }
}
