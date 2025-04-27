import 'package:flutter/material.dart';

import 'widgets/onboarding_view_body.dart';

class OnboardingView extends StatelessWidget {
  static const routePath = '/onboarding';
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: OnboardingViewBody()));
  }
}
