import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellness/core/routes/route_generator.dart';

import 'core/routes/route_model.dart';

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Scale Demo',
      theme: ThemeData(textTheme: GoogleFonts.robotoTextTheme()),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: RouteNames.onBoardingScreens,
    );
  }
}
