import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wellness/features/register/ui/widgets/already_have_account_text.dart';
import 'package:wellness/features/register/ui/widgets/sign_up_bloc_listener.dart';
import 'package:wellness/features/register/ui/widgets/sign_up_form.dart';

import '../../../../core/ui/text_styles.dart';
import '../../../../core/ui/widgets/app_button.dart';
import '../../logic/cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sign Up', style: TextStyles.heading1),
                SizedBox(height: 8.h),
                Text(
                  'Sign up now and start exploring all that our app has to offer. We\'re excited to welcome you to our community!',
                  style: TextStyles.caption.copyWith(
                    color: Color(0xff757575).withValues(alpha: 0.7),
                  ),
                ),
                SizedBox(height: 36),

                Column(
                  children: [
                    RegisterForm(),
                    SizedBox(height: 40),
                    AppTextButton(
                      onPressed: () {
                        validateThenDoLogin(context);
                      },
                      buttonText: 'Sign Up',
                      textStyle: TextStyles.subtitle.copyWith(
                        color: Colors.white,
                      ),
                      buttonHeight: 56,
                    ),
                    SizedBox(height: 40,),
                    AlreadyHaveAccountText(),
                    SignUpBlocListener(),
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
    if (context.read<RegisterCubit>().formKey.currentState!.validate()) {
      context.read<RegisterCubit>().emitRegisterStates();
    }
  }
}