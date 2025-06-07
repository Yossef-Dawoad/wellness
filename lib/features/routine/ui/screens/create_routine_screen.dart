import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wellness/core/ui/widgets/app_button.dart';
import 'package:wellness/core/ui/widgets/app_text_field.dart';
import 'package:wellness/features/routine/ui/widgets/date_text_field.dart';

import '../../../../core/ui/text_styles.dart';

class CreateRoutineScreen extends StatelessWidget {
  const CreateRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Routine', style: TextStyles.heading2,),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppTextField(hintText: 'Routine Title'),
                SizedBox(height: 12.h),
                AppTextField(hintText: 'Description',),
                SizedBox(height: 12.h),
                DateTextField(),
                SizedBox(height: 12.h),
                DateTextField(),
                SizedBox(height: 40,),
                AppTextButton(onPressed: (){}, buttonText: 'Save', textStyle: TextStyles.subtitle.copyWith(fontWeight: FontWeight.bold, color: Colors.white,),buttonHeight: 55,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}