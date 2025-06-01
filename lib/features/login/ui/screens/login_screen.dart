import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wellness/features/login/ui/widgets/dont_have_acount_text.dart';

import '../../../../core/ui/text_styles.dart';
import '../../../../core/ui/widgets/app_button.dart';
import '../../logic/cubit/login_cubit.dart';
import '../widgets/email_and_password.dart';
import '../widgets/login_cubit_listener.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Login', style: TextStyles.heading1),
                SizedBox(height: 8.h),
                Text(
                  'We\'re excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in.',
                  style: TextStyles.caption.copyWith(
                    color: Color(0xff757575).withValues(alpha: 0.7),
                  ),
                ),
                SizedBox(height: 36),

                Column(
                  children: [
                    EmailAndPassword(),
                    const SizedBox(height: 40),
                    AppTextButton(
                      onPressed: () {
                        validateThenDoLogin(context);
                      },
                      buttonText: 'Login',
                      textStyle: TextStyles.subtitle.copyWith(
                        color: Colors.white,
                      ),
                      buttonHeight: 56,
                    ),
                    SizedBox(height: 40,),
                    DontHaveAcountText(),
                    LoginCubitListener(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    if (context.read<LoginCubit>().formKey.currentState!.validate()) {
      context.read<LoginCubit>().emitLoginStates();
    }
  }
}
