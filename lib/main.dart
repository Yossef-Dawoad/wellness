import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

import 'features/workouts_listing/presentations/dashboard_screen.dart';
import 'features/workouts_listing/presentations/exercise_screen.dart';
=======
import 'package:logging/logging.dart';
import 'package:wellness/fitness_app.dart';
import 'core/service_locator/sl.dart';
>>>>>>> 6282a6ac1f51a294411d18ba2353918f2e0825ad

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Important for async setup
  await setupLocator(); // Configure GetIt
  _setupLogging();
  runApp(FitnessApp());
}

<<<<<<< HEAD
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
=======
void _setupLogging() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) debugPrint('[${record.level.name}]: ${record.time}: ${record.message}');
  });
>>>>>>> 6282a6ac1f51a294411d18ba2353918f2e0825ad
}
