import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellness/core/routes/route_generator.dart';


class FitnessApp extends StatelessWidget {
  final String initialRoute;
  const FitnessApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Animated Scale Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: GoogleFonts.robotoTextTheme()),
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: initialRoute,
      ),
    );
  }
}
