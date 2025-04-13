import 'package:flutter/material.dart';

// Constants for scale configuration
// const int MIN_SCALE_VALUE = 30;
// const int MAX_SCALE_VALUE = 200;
const int MAJOR_TICK_COUNT = 7;

class ScalePainter extends CustomPainter {
  final double fingerPositionX;
  final double width;
  final int currentValue;

  final int minValue;
  final int maxValue;
  final bool isKg;

  //  int SCALE_RANGE = maxValue - minValue;
  //  double VALUE_SPACING = SCALE_RANGE / (MAJOR_TICK_COUNT - 1);

  // Cache for text painters
  static final Map<String, TextPainter> _textPainterCache = {};

  // Configuration constants
  static const double INTERACTION_RADIUS = 30.0;
  static const double MAJOR_TICK_BASE_HEIGHT = 20.0;
  static const double MINOR_TICK_BASE_HEIGHT = 10.0;
  static const double MAX_TICK_EXTENSION = 20.0;

  const ScalePainter({
    required this.minValue,
    required this.maxValue,
    required this.isKg,
    required this.currentValue,
    required this.fingerPositionX,
    required this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double centerLineY = size.height / 2;
    final double majorTickSpacing = size.width / (MAJOR_TICK_COUNT - 1);

    // Calculate current value once
    final int currentValue = _calculateCurrentValue();

    // Notify about value change
    // onValueChanged?.call(currentValue);

    // Draw the scale components
    _drawMajorTicks(canvas, size, centerLineY, majorTickSpacing, currentValue);
    _drawCurrentValueText(canvas, size, centerLineY, currentValue);
  }

  int _calculateCurrentValue() {
    final SCALE_RANGE = maxValue - minValue;
    return (minValue + (fingerPositionX / width) * SCALE_RANGE).round().clamp(minValue, maxValue);
  }

  void _drawMajorTicks(
    Canvas canvas,
    Size size,
    double centerLineY,
    double majorTickSpacing,
    int currentValue,
  ) {
    for (int i = 0; i < MAJOR_TICK_COUNT; i++) {
      double tickX = i * majorTickSpacing;

      // Calculate proximity factor for animation
      double distanceToFinger = (tickX - fingerPositionX).abs();
      double proximityFactor = _calculateProximityFactor(distanceToFinger, INTERACTION_RADIUS);

      // Draw the major tick
      _drawTick(
        canvas,
        tickX,
        centerLineY,
        MAJOR_TICK_BASE_HEIGHT + (proximityFactor * MAX_TICK_EXTENSION),
        proximityFactor,
        1.5, // Stroke width multiplier for major ticks
      );

      // Calculate and draw the tick label
      int tickValue = _calculateTickValue(i, currentValue);
      if (i != 3) {
        // Skip center tick label
        _drawTickLabel(canvas, tickX, centerLineY, tickValue, proximityFactor);
      }

      // Draw minor ticks between major ticks
      if (i < MAJOR_TICK_COUNT - 1) {
        _drawMinorTicks(canvas, tickX, majorTickSpacing, centerLineY, i);
      }
    }
  }

  void _drawMinorTicks(
    Canvas canvas,
    double tickX,
    double majorTickSpacing,
    double centerLineY,
    int majorTickIndex,
  ) {
    double nextTickX = (majorTickIndex + 1) * majorTickSpacing;
    double segmentWidth = nextTickX - tickX;

    // Position minor ticks at 1/3 and 2/3 of the distance between major ticks
    double minorTickX1 = tickX + segmentWidth / 3;
    double minorTickX2 = tickX + 2 * segmentWidth / 3;

    // Draw first minor tick
    double distanceToMinor1 = (minorTickX1 - fingerPositionX).abs();
    double proximityFactorMinor1 =
        _calculateProximityFactor(distanceToMinor1, INTERACTION_RADIUS) * 0.5;
    _drawTick(
      canvas,
      minorTickX1,
      centerLineY,
      MINOR_TICK_BASE_HEIGHT + (proximityFactorMinor1 * MAX_TICK_EXTENSION),
      proximityFactorMinor1 * 2, // Double effect for visibility
      1.0, // Standard stroke width
    );

    // Draw second minor tick
    double distanceToMinor2 = (minorTickX2 - fingerPositionX).abs();
    double proximityFactorMinor2 =
        _calculateProximityFactor(distanceToMinor2, INTERACTION_RADIUS) * 0.5;
    _drawTick(
      canvas,
      minorTickX2,
      centerLineY,
      MINOR_TICK_BASE_HEIGHT + (proximityFactorMinor2 * MAX_TICK_EXTENSION),
      proximityFactorMinor2 * 2, // Double effect for visibility
      1.0, // Standard stroke width
    );
  }

  double _calculateProximityFactor(double distance, double radius) {
    return distance < radius ? (radius - distance) / radius : 0.0;
  }

  void _drawTick(
    Canvas canvas,
    double x,
    double centerY,
    double height,
    double proximityFactor,
    double strokeWidthMultiplier,
  ) {
    Color tickColor =
        Color.lerp(
          Colors.grey[300]!, // Grey when far
          Colors.black, // Black when under finger
          proximityFactor,
        )!;

    // Draw the tick above the center line
    canvas.drawLine(
      Offset(x, centerY),
      Offset(x, centerY - height),
      Paint()
        ..color = tickColor
        ..strokeWidth = 3.0 * strokeWidthMultiplier
        ..strokeCap = StrokeCap.round,
    );

    // Mirror the tick below the center line
    canvas.drawLine(
      Offset(x, centerY),
      Offset(x, centerY + height),
      Paint()
        ..color = tickColor
        ..strokeWidth = 3.0 * strokeWidthMultiplier
        ..strokeCap = StrokeCap.round,
    );
  }

  int _calculateTickValue(int tickPosition, int currentValue) {
    // Calculate the fixed values for each tick position
    // This ensures labels show the actual scale values at their positions
    final SCALE_RANGE = maxValue - minValue;
    int baseValue = minValue + ((tickPosition * SCALE_RANGE) / (MAJOR_TICK_COUNT - 1)).round();
    return baseValue.clamp(minValue, maxValue);
  }

  void _drawTickLabel(
    Canvas canvas,
    double tickX,
    double centerY,
    int value,
    double proximityFactor,
  ) {
    final String cacheKey = '$value-$proximityFactor';

    if (!_textPainterCache.containsKey(cacheKey)) {
      final TextStyle labelStyle = TextStyle(
        color: Color.lerp(Colors.grey[400]!, Colors.grey[700]!, proximityFactor),
        fontSize: 12,
      );

      final TextSpan labelSpan = TextSpan(text: '$value', style: labelStyle);
      final TextPainter labelPainter = TextPainter(
        text: labelSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      labelPainter.layout();
      _textPainterCache[cacheKey] = labelPainter;
    }

    final TextPainter painter = _textPainterCache[cacheKey]!;
    double labelX = tickX - painter.width / 2;
    // Increase the offset to move labels further down from the center line
    double labelY = centerY + 50;
    painter.paint(canvas, Offset(labelX, labelY));
  }

  void _drawCurrentValueText(Canvas canvas, Size size, double centerY, int currentValue) {
    final String cacheKey = 'current-$currentValue';

    if (!_textPainterCache.containsKey(cacheKey)) {
      final TextStyle valueStyle = TextStyle(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      );

      final TextSpan valueSpan = TextSpan(text: '$currentValue', style: valueStyle);
      final TextPainter valuePainter = TextPainter(
        text: valueSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      valuePainter.layout();
      _textPainterCache[cacheKey] = valuePainter;
    }

    final TextPainter painter = _textPainterCache[cacheKey]!;
    double valueX = (size.width / 2) - painter.width / 2;
    // Adjust the position of the current value text to be lower
    double valueY = centerY + 70;
    painter.paint(canvas, Offset(valueX, valueY));
  }

  @override
  bool shouldRepaint(covariant ScalePainter oldDelegate) {
    // Only repaint when the finger position has changed significantly
    return (oldDelegate.fingerPositionX - fingerPositionX).abs() > 0.5;
  }
}
