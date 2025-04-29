import 'package:flutter/material.dart' show Route, RouteSettings, MaterialPageRoute, Scaffold;
import 'package:wellness/features/user_questionnaire/presentation/weight_scale_selector_screen.dart';

import '../../features/onboarding/presentaions/onboarding_view.dart';
import '../../features/user_questionnaire/presentation/exercise_type_selector_screen.dart';
import 'route_model.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return switch (settings.name) {
      RouteNames.onBoardingScreens => MaterialPageRoute(builder: (_) => const OnboardingView()),
      RouteNames.weightScaleScreen => MaterialPageRoute(builder: (_) => const WeightScalePage()),
      RouteNames.exerciseTypeSelectorScreen => MaterialPageRoute(
        builder: (_) => const ExerciseTypeSelectorPage(),
      ),

      _ => MaterialPageRoute(builder: (_) => const Scaffold()),
    };
  }
}
