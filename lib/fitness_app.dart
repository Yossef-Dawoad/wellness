import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellness/core/routes/route_generator.dart';

import 'core/routes/route_model.dart';

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

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
        initialRoute: RouteNames.loginScreen,
      ),
    );
  }
}
