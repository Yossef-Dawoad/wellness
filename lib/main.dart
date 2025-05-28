import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logging/logging.dart';
import 'package:wellness/fitness_app.dart';
import 'core/service_locator/sl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Important for async setup
  await setupLocator(); // Configure GetIt
  await ScreenUtil.ensureScreenSize();
  _setupLogging();
  runApp(FitnessApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) debugPrint('[${record.level.name}]: ${record.time}: ${record.message}');
  });
}
