import 'package:flutter/material.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppTextField(hintText: 'Routine Title'),
              AppTextField(hintText: 'Description',),
              DateTextField(),
              DateTextField(),
            ],
          ),
        ),
      ),
    );
  }
}