import 'package:flutter/material.dart'
    show Route, RouteSettings, MaterialPageRoute, Scaffold;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/features/login/logic/cubit/login_cubit.dart';
import 'package:wellness/features/login/ui/screens/login_screen.dart';
import 'package:wellness/features/register/ui/screens/register_screen.dart';
import 'package:wellness/features/user_questionnaire/presentation/weight_scale_selector_screen.dart';

import '../../features/onboarding/presentaions/onboarding_view.dart';
import '../../features/register/logic/cubit/register_cubit.dart';
import '../../features/user_questionnaire/presentation/exercise_type_selector_screen.dart';
import '../service_locator/sl.dart';
import 'route_model.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return switch (settings.name) {
      RouteNames.onBoardingScreens => MaterialPageRoute(
        builder: (_) => const OnboardingView(),
      ),
      RouteNames.loginScreen => MaterialPageRoute(
        builder:
            (_) => BlocProvider(
              create: (context) => sl<LoginCubit>(),
              child:  LoginScreen(),
            ),
      ),
      RouteNames.registerScreen => MaterialPageRoute(
        builder:
            (_) => BlocProvider(
              create: (context) => sl<RegisterCubit>(),
              child:  RegisterScreen(),
            ),
      ),
      RouteNames.weightScaleScreen => MaterialPageRoute(
        builder: (_) => const WeightScalePage(),
      ),
      RouteNames.exerciseTypeSelectorScreen => MaterialPageRoute(
        builder: (_) => const ExerciseTypeSelectorPage(),
      ),

      _ => MaterialPageRoute(builder: (_) => const Scaffold()),
    };
  }
}
