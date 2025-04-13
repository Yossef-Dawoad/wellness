import 'package:flutter/material.dart';
import 'package:wellness/features/user_questionnaire/presentation/widgets/scale_dashed_painter.dart';

const int DEFAULT_SCALE_VALUE = 60;
const int MIN_SCALE_VALUE_KG = 30;
const int MAX_SCALE_VALUE_KG = 200;
const int MIN_SCALE_VALUE_LB = 65; // 30kg in lb
const int MAX_SCALE_VALUE_LB = 440; // 200kg in lb

class AnimatedScaleWidget extends StatefulWidget {
  final double width;
  final double height;
  final ValueNotifier<int> valueNotifier;
  final ValueNotifier<bool> isKgSelectedNotifier;

  const AnimatedScaleWidget({
    super.key,
    required this.width,
    required this.height,
    required this.valueNotifier,
    required this.isKgSelectedNotifier,
  });

  @override
  State<AnimatedScaleWidget> createState() => _AnimatedScaleWidgetState();
}

class _AnimatedScaleWidgetState extends State<AnimatedScaleWidget>
    with SingleTickerProviderStateMixin {
  // The horizontal position (in pixels) of the user's finger.
  late double _fingerPositionX;
  late AnimationController _controller;
  late Animation<double> _animation;

  // Add a ValueNotifier to only update what's needed
  late ValueNotifier<double> _fingerPositionNotifier;

  // Use the passed valueNotifier instead of creating a new one
  ValueNotifier<int> get scaleValueNotifier => widget.valueNotifier;
  ValueNotifier<bool> get isKgSelectedNotifier => widget.isKgSelectedNotifier;

  // Dynamic min and max values based on unit
  int get minScaleValue => isKgSelectedNotifier.value ? MIN_SCALE_VALUE_KG : MIN_SCALE_VALUE_LB;
  int get maxScaleValue => isKgSelectedNotifier.value ? MAX_SCALE_VALUE_KG : MAX_SCALE_VALUE_LB;
  int get scaleRange => maxScaleValue - minScaleValue;

  @override
  void initState() {
    super.initState();
    // Calculate initial finger position based on current value
    _fingerPositionX = _calculateFingerPosition(scaleValueNotifier.value);
    _fingerPositionNotifier = ValueNotifier<double>(_fingerPositionX);

    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    _animation = Tween<double>(
      begin: _fingerPositionX,
      end: _fingerPositionX,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.addListener(_onAnimationUpdate);

    // Listen for unit changes to update finger position
    isKgSelectedNotifier.addListener(_onUnitChanged);
  }

  // Calculate finger position from scale value
  double _calculateFingerPosition(int value) {
    return ((value - minScaleValue) / scaleRange) * widget.width;
  }

  // Handle unit changes
  void _onUnitChanged() {
    // Recalculate finger position based on current value with new unit range
    _fingerPositionX = _calculateFingerPosition(scaleValueNotifier.value);
    _fingerPositionNotifier.value = _fingerPositionX;
  }

  void _onAnimationUpdate() {
    _fingerPositionX = _animation.value;
    _fingerPositionNotifier.value = _fingerPositionX;
    _updateScaleValue();
  }

  void _updateScaleValue() {
    int currentValue = _calculateScaleValue(_fingerPositionX);
    if (scaleValueNotifier.value != currentValue) {
      scaleValueNotifier.value = currentValue;
    }
  }

  // Extracted method for calculating scale value from position
  int _calculateScaleValue(double position) {
    return (minScaleValue + (position / widget.width) * scaleRange).round().clamp(
      minScaleValue,
      maxScaleValue,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _fingerPositionNotifier.dispose();
    isKgSelectedNotifier.removeListener(_onUnitChanged);
    super.dispose();
  }

  // Update hover position when the user touches down.
  void _onPanStart(DragStartDetails details) {
    _controller.stop();
    _updateFingerPosition(details.globalPosition);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _updateFingerPosition(details.globalPosition);
  }

  void _updateFingerPosition(Offset globalPosition) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset localPosition = box.globalToLocal(globalPosition);
    // Clamp the value so it never goes outside the widget's bounds.
    _fingerPositionX = localPosition.dx.clamp(0.0, widget.width);
    _fingerPositionNotifier.value = _fingerPositionX;
    _updateScaleValue();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      child: ValueListenableBuilder<double>(
        valueListenable: _fingerPositionNotifier,
        builder: (context, fingerPosition, _) {
          return ValueListenableBuilder<bool>(
            valueListenable: isKgSelectedNotifier,
            builder: (context, isKgSelected, _) {
              // Calculate the value here instead of in the painter
              final currentValue = _calculateScaleValue(fingerPosition);

              // Update the value notifier using post-frame callback to avoid layout issues
              if (mounted && scaleValueNotifier.value != currentValue) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted && scaleValueNotifier.value != currentValue) {
                    scaleValueNotifier.value = currentValue;
                  }
                });
              }

              return RepaintBoundary(
                child: CustomPaint(
                  size: Size(widget.width, widget.height),
                  painter: ScalePainter(
                    fingerPositionX: fingerPosition,
                    width: widget.width,
                    currentValue: currentValue,
                    minValue: minScaleValue,
                    maxValue: maxScaleValue,
                    isKg: isKgSelected,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
