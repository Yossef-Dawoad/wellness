import 'package:flutter/material.dart';
import 'package:wellness/features/user_questionnaire/presentation/components/animated_scale_widget.dart';

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
      appBar: AppBar(
        title: ValueListenableBuilder<int>(
          valueListenable: scaleValueNotifier,
          builder: (context, value, child) {
            return Text('Scale Value: $value');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
            Text(
              'How much \nyour weight?',
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w900, color: Colors.black),
            ),
            SizedBox(height: 32.0),
            UnitToggleButton(isKgSelectedNotifier: isKgSelectedNotifier),
            const SizedBox(height: 40.0),
            ScaleValueUnit(
              scaleValueNotifier: scaleValueNotifier,
              isKgSelectedNotifier: isKgSelectedNotifier,
            ),
            SizedBox(height: 24.0),
            // Scale widget
            Center(
              child: AnimatedScaleWidget(
                width: MediaQuery.sizeOf(context).width - 48,
                height: 100,
                valueNotifier: scaleValueNotifier,
                isKgSelectedNotifier: isKgSelectedNotifier,
              ),
            ),
            // Explanation text
            const Spacer(),
            Center(
              child: Text(
                'This is to set up\nrecommendations just for you.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 40.0),
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
    );
  }
}

class UnitToggleButton extends StatelessWidget {
  const UnitToggleButton({super.key, required this.isKgSelectedNotifier});
  final ValueNotifier<bool> isKgSelectedNotifier;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 40,
        width: 140,
        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
        child: ValueListenableBuilder<bool>(
          valueListenable: isKgSelectedNotifier,
          builder: (context, isKgSelected, _) {
            return Row(
              children: [
                // kg toggle
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (!isKgSelected) {
                        isKgSelectedNotifier.value = true;
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isKgSelected ? Colors.black : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'kg',
                          style: TextStyle(
                            color: isKgSelected ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // lb toggle
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (isKgSelected) {
                        isKgSelectedNotifier.value = false;
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: !isKgSelected ? Colors.black : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'lb',
                          style: TextStyle(
                            color: !isKgSelected ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ScaleValueUnit extends StatelessWidget {
  const ScaleValueUnit({
    super.key,
    required this.scaleValueNotifier,
    required this.isKgSelectedNotifier,
  });

  final ValueNotifier<int> scaleValueNotifier;
  final ValueNotifier<bool> isKgSelectedNotifier;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<int>(
        valueListenable: scaleValueNotifier,
        builder: (context, value, child) {
          return ValueListenableBuilder<bool>(
            valueListenable: isKgSelectedNotifier,
            builder: (context, isKgSelected, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value.toString(),
                    style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      isKgSelected ? 'kg' : 'lb',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
