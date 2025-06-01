import 'package:flutter/material.dart';
import 'package:wellness/features/user_questionnaire/presentation/components/animated_scale_widget.dart';

import '../../../core/common/common_animations.dart';
import '../../../core/common/services/local_database/shared_pref/shared_pref_helper.dart';
import '../../../core/routes/route_model.dart';
import '../../../core/service_locator/sl.dart';
import '../data/user_questionaire_keys.dart';
import 'exercise_type_selector_screen.dart';
import 'widgets/scale_value_unit.dart';
import 'widgets/unit_toggle_btn.dart';

class WeightScalePage extends StatefulWidget {
  const WeightScalePage({super.key});

  @override
  State<WeightScalePage> createState() => _WeightScalePageState();
}

class _WeightScalePageState extends State<WeightScalePage> {
  late final ValueNotifier<int> scaleValueNotifier;
  // Convert to ValueNotifier for better reactivity
  late final ValueNotifier<bool> isKgSelectedNotifier;

  @override
  void initState() {
    super.initState();
    scaleValueNotifier = ValueNotifier<int>(DEFAULT_SCALE_VALUE);
    isKgSelectedNotifier = ValueNotifier<bool>(true);

    // Listen for unit changes and convert weight values
    isKgSelectedNotifier.addListener(_convertWeightValue);
  }

  // Convert weight between kg and lb when unit changes
  void _convertWeightValue() {
    final bool isKg = isKgSelectedNotifier.value;
    final int currentValue = scaleValueNotifier.value;

    if (isKg) {
      // Convert from lb to kg (lb / 2.20462)
      final int kgValue = (currentValue / 2.20462).round();
      scaleValueNotifier.value = kgValue;
    } else {
      // Convert from kg to lb (kg * 2.20462)
      final int lbValue = (currentValue * 2.20462).round();
      scaleValueNotifier.value = lbValue;
    }
  }

  @override
  void dispose() {
    scaleValueNotifier.dispose();
    isKgSelectedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              ClassicSlideWithFadeInAnimation(
                child: Text(
                  'How much \nyour weight?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              ClassicSlideWithFadeInAnimation(
                delay: AnimationDurations.medium,
                child: UnitToggleButton(isKgSelectedNotifier: isKgSelectedNotifier),
              ),
              const SizedBox(height: 40.0),
              ClassicSlideWithFadeInAnimation(
                child: ScaleValueUnit(
                  scaleValueNotifier: scaleValueNotifier,
                  isKgSelectedNotifier: isKgSelectedNotifier,
                ),
              ),
              SizedBox(height: 24.0),
              // Scale widget
              ClassicSlideWithFadeInAnimation(
                delay: AnimationDurations.long,
                child: Center(
                  child: AnimatedScaleWidget(
                    width: MediaQuery.sizeOf(context).width - 48,
                    height: 100,
                    valueNotifier: scaleValueNotifier,
                    isKgSelectedNotifier: isKgSelectedNotifier,
                  ),
                ),
              ),
              // Explanation text
              const Spacer(),
              ClassicSlideWithFadeInAnimation(
                delay: AnimationDurations.longer,
                child: Center(
                  child: Text(
                    'This is to set up\nrecommendations just for you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
              // Navigation buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Handle back navigation
                      Navigator.pop(context);
                    },
                    child: Text('Back', style: TextStyle(color: Colors.grey[400], fontSize: 16.0)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle next navigation
                      // save the value
                      sl<SharedPrefHelper>().setValue<double>(
                        UserQuestionaireKeys.weight,
                        scaleValueNotifier.value.toDouble(),
                      );
                      Navigator.pushNamed(context, RouteNames.exerciseTypeSelectorScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
