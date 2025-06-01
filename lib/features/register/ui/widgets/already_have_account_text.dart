import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wellness/core/utils/helper/extension.dart';

import '../../../../core/routes/route_model.dart';
import '../../../../core/ui/text_styles.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Already have an account?',
            style: TextStyles.subtitle,
          ),
          TextSpan(
            text: ' Login',
            style: TextStyles.body.copyWith(color: Color(0xff247CFF), fontWeight: FontWeight.w500),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushReplacementNamed(RouteNames.loginScreen);
              },
          ),
        ],
      ),
    );
  }
}