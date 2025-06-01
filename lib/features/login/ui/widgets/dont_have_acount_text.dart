import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wellness/core/utils/helper/extension.dart';

import '../../../../core/routes/route_model.dart';
import '../../../../core/ui/text_styles.dart';

class DontHaveAcountText extends StatelessWidget {
  const DontHaveAcountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: 'Don\'t have an account?', style: TextStyles.subtitle),
          TextSpan(
            text: ' Sign Up',
            style: TextStyles.body.copyWith(
              color: Color(0xff247CFF),
              fontWeight: FontWeight.w500,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    print('push register Screen');
                    context.pushNamed(RouteNames.registerScreen);
                  },
          ),
        ],
      ),
    );
  }
}
