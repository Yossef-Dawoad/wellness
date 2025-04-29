import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:wellness/features/user_questionnaire/presentation/activity_level_selector_screen.dart';
import 'package:wellness/features/user_questionnaire/presentation/goal_selector_screen.dart';

//import 'package:wellness/height_view.dart';
import 'features/onboarding/presentaions/onboarding_view.dart';
import 'features/user_questionnaire/presentation/gender_type_selector_screen.dart';
import 'features/user_questionnaire/presentation/weight_scale_selector_screen.dart';
import 'features/workouts_listing/presentations/dashboard_screen.dart';
import 'features/workouts_listing/presentations/workouts_screen.dart';

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
      debugShowCheckedModeBanner: false,
      // home: HeightPickerScreen(),
      // home: OnboardingView(),
      //home: DashboardScreen(),
      // // home: WorkoutsScreen(),
      // // home: WeightScalePage(),
      home: GenderTypeSelectorScreen(),
      // home: GoalSelectorScreen(),
      //home: ActivityLevelSelectorScreen(),

    );
  }
}
