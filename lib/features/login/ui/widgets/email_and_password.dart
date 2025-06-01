import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ui/widgets/app_text_field_form.dart';
import '../../logic/cubit/login_cubit.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  // final formKey = GlobalKey<FormState>();
  bool isObsecureText = true;
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'Email',
            
            validator: (value) {
              if (value == null ||
                  value.isEmpty) {
                return 'Please enter valid password';
              }
            },
            controller: context.read<LoginCubit>().userNameController,
          ),
          SizedBox(height: 18),
          AppTextFormField(
            hintText: 'Password',
            isObsecureText: isObsecureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isObsecureText = !isObsecureText;
                });
              },
              child: Icon(
                isObsecureText ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            controller: context.read<LoginCubit>().passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter valid password';
              }
            },
          ),
          SizedBox(height: 24),
          
        ],
      ),
    );
  }

  
}
