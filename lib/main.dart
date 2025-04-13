import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:wellness/features/user_questionnaire/presentation/weight_screen.dart';

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
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      home: WeightScalePage(),
    );
  }
}
// anthor test code 