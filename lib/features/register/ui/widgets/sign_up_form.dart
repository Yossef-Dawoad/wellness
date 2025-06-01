import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/features/register/logic/cubit/register_cubit.dart';

import '../../../../core/ui/widgets/app_text_field_form.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool isPasswordObscureText = true;
  

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<RegisterCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'user name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid name';
              }
            },
            controller: context.read<RegisterCubit>().userNameController,
          ),
          SizedBox(height: 18,),
          AppTextFormField(
            hintText: 'Email',
            validator: (value) {
              if (value == null ||
                  value.isEmpty) {
                return 'Please enter a valid email';
              }
            },
            controller: context.read<RegisterCubit>().emailController,
          ),
          SizedBox(height: 18,),
          AppTextFormField(
            controller: context.read<RegisterCubit>().passwordController,
            hintText: 'Password',
            isObsecureText: isPasswordObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordObscureText = !isPasswordObscureText;
                });
              },
              child: Icon(
                isPasswordObscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
            },
          ),
          SizedBox(height: 18,),     
        ],
      ),
    );
  }

}