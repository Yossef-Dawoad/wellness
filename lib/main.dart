import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

import 'features/workouts_listing/presentations/dashboard_screen.dart';
import 'features/workouts_listing/presentations/exercise_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Scale Demo',
      theme: ThemeData(textTheme: GoogleFonts.robotoTextTheme()),
      // home: HeightPickerScreen(),
      // home: OnboardingView(),
      // home: ExerciseScreen(),
      home: DashboardScreen(),
      // // home: WorkoutsScreen(),
      // // home: WeightScalePage(),
    );
  }
}
