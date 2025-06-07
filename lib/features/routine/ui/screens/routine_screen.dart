import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wellness/core/ui/color_palette.dart';

import '../../../../core/routes/route_model.dart';
import '../../../../core/ui/text_styles.dart';
import '../../../../core/utils/helper/extension.dart';

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 16.h),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text('Routines', style: TextStyles.heading2),
                    ),
                  ),
                  // Spacer(),
                  IconButton(
                    onPressed: () {
                      context.pushNamed(RouteNames.addRoutine);
                    },
                    icon: Icon(Icons.add, size: 25, color: Palette.textPrimary),
                  ),
                ],
              ),

              SizedBox(height: 40),
              Expanded(
                child: ListView.separated(
                   separatorBuilder: (context, index) => SizedBox(height: 6,),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Palette.cardBackground,
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/splash/wellness_logo.png',
                          width: 53,
                        ),
                        title: Text(
                          'PPL Routine',
                          style: TextStyles.heading3.copyWith(fontSize: 16),
                        ),
                        subtitle: Text(
                          '3 days and rest one',
                          style: TextStyles.caption,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
