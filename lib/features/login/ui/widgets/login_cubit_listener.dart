import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/core/routes/route_model.dart';
import 'package:wellness/core/ui/color_palette.dart';
import 'package:wellness/core/utils/helper/extension.dart';

import '../../../../core/ui/text_styles.dart';
import '../../logic/cubit/login_cubit.dart';
import '../../logic/cubit/login_state.dart';

class LoginCubitListener extends StatelessWidget {
  const LoginCubitListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) {
        return current is LoginLoading || current is LoginSuccess || current is LoginError;
      },
      listener: (context, state) {
        switch (state) {
          case LoginLoading():
            showDialog(
              context: context,
              builder:
                  (context) => Center(
                    child: CircularProgressIndicator(
                      color: Palette.textPrimary,
                    ),
                  ),
            );
          case LoginSuccess():
            context.pop();
            context.pushNamed(RouteNames.onBoardingScreens);
          case LoginError(error: final error):
            setUpErrorState(context, error);
          default:
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void setUpErrorState(BuildContext context, String error) {
    context.pop();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            icon: const Icon(Icons.error, color: Colors.red, size: 32),
            content: Text(error, style: TextStyles.body),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text('Got it', style: TextStyles.subtitle),
              ),
            ],
          ),
    );
  }
}