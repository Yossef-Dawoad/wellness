
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/core/ui/color_palette.dart';
import 'package:wellness/core/utils/helper/extension.dart';

import '../../../../core/routes/route_model.dart';
import '../../../../core/ui/text_styles.dart';
import '../../logic/cubit/register_cubit.dart';
import '../../logic/cubit/register_state.dart';

class SignUpBlocListener extends StatelessWidget {
  const SignUpBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen:
          (previous, current){
        return current is RegisterLoading || current is RegisterSuccess || current is RegisterError;
      },
      listener: (context, state) {
        switch (state) {
          case RegisterLoading():
            showDialog(
              context: context,
              builder:
                  (context) => Center(
                    child: CircularProgressIndicator(
                      color: Palette.textPrimary,
                    ),
                  ),
            );
          case RegisterSuccess():
            context.pop();
            showSuccessDialog(context);
          case RegisterError(error: final error):
            setupErrorState(context, error);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Signup Successful'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Congratulations, you have signed up successfully!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                disabledForegroundColor: Colors.grey.withAlpha(3),
              ),
              onPressed: () {
                context.pushNamed(RouteNames.loginScreen);
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }

  void setupErrorState(BuildContext context, String error) {
    context.pop();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            icon: const Icon(Icons.error, color: Colors.red, size: 32),
            content: Text(error, style: TextStyles.subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text('Got it', style: TextStyles.body.copyWith(color: Color(0xff247CFF), fontWeight: FontWeight.w500)),
              ),
            ],
          ),
    );
  }
}
