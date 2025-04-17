// Flutter Animation Snippets for Wellness App
// These snippets provide implementation examples for animations and transitions
// that can enhance the user experience in the wellness app

import 'package:flutter/material.dart';

// ==================== ANIMATION CONSTANTS ====================

/// Standard durations for animations throughout the app.
///
/// Using these constants helps maintain consistency in animation timing.
class AnimationDurations {
  /// Short duration for subtle animations (200ms)
  static const Duration short = Duration(milliseconds: 200);

  /// Medium duration for standard animations (350ms)
  static const Duration medium = Duration(milliseconds: 350);

  /// Long duration for complex animations (500ms)
  static const Duration long = Duration(milliseconds: 500);

  /// Long duration for complex animations (700ms)
  static const Duration longer = Duration(milliseconds: 700);
}

/// Standard animation curves for use throughout the app.
///
/// Using these constants helps maintain consistency in animation behavior.
class AnimationCurves {
  /// Standard easing for most animations
  static const Curve standard = Curves.easeInOut;

  /// Deceleration curve for elements entering the screen
  static const Curve decelerate = Curves.easeOutCubic;

  /// Acceleration curve for elements leaving the screen
  static const Curve accelerate = Curves.easeInCubic;

  /// Bouncy curve for playful animations
  static const Curve bounce = Curves.elasticOut;
}

/// A mixin that provides common animation functionality.
///
/// This mixin helps reduce code duplication in animation widgets by providing
/// standard methods for creating and managing animations.
mixin AutoDisposeAnimationControllerMixin<T extends StatefulWidget> on State<T> {
  /// Creates an animation controller with the specified duration.
  ///
  /// The controller will automatically be disposed when the state is disposed.

  @protected
  AnimationController createController({
    required TickerProvider vsync,
    required Duration duration,
    double lowerBound = 0.0,
    double upperBound = 1.0,
  }) {
    final controller = AnimationController(
      vsync: vsync,
      duration: duration,
      lowerBound: lowerBound,
      upperBound: upperBound,
    );

    // Ensure the controller is disposed when the state is disposed
    _controllers.add(controller);
    return controller;
  }

  // Track all controllers created by this mixin
  final List<AnimationController> _controllers = [];

  @override
  void dispose() {
    // Dispose all controllers when the state is disposed
    for (final ctrl in _controllers) {
      ctrl.dispose();
    }

    _controllers.clear();
    super.dispose();
  }
}

/// Extension on [AnimationController] to simplify creating common animations.
extension AnimationControllerExtension on AnimationController {
  /// Creates a fade animation from 0.0 to 1.0
  Animation<double> fadeIn(Curve curve) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: this, curve: curve));
  }

  /// Creates a fade animation from 1.0 to 0.0
  Animation<double> fadeOut(Curve curve) {
    return Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: this, curve: curve));
  }

  /// Creates a slide animation from the given offset to Offset.zero
  Animation<Offset> slideIn(Offset beginOffset, Curve curve) {
    return Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: this, curve: curve));
  }

  /// Creates a scale animation between the given values
  Animation<double> scale(double begin, double end, Curve curve) {
    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(parent: this, curve: curve));
  }
}

// ==================== ANIMATION WIDGETS ====================

/// A widget that fades its child into view.
///
/// This animation starts fully transparent and animates to fully opaque.
/// Useful for elements that need to appear subtly on the screen.
class FadeInAnimation extends StatefulWidget {
  /// The widget to fade in
  final Widget child;

  /// Duration of the fade animation
  final Duration duration;

  /// Delay before starting the animation
  final Duration delay;

  /// Animation curve to control the timing function
  final Curve curve;

  /// Creates a fade-in animation widget.
  ///
  /// The [child] parameter is required and represents the widget to animate.
  /// The [duration] controls how long the fade takes.
  /// The [delay] sets how long to wait before starting the animation.
  /// The [curve] determines the rate of change of the animation.
  const FadeInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 350),
    this.delay = Duration.zero,
    this.curve = Curves.easeInOut,
  });

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin, AutoDisposeAnimationControllerMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = createController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);

    // Delay the start of the animation if specified
    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  //[TODO] research of the controllers and animations needs to be disposed

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }
}

/// A widget that slides its child into view from a specified offset.
///
/// This animation starts at [beginOffset] and animates to Offset.zero.
/// Useful for elements that need to appear with a sliding motion.
class SlideInAnimation extends StatefulWidget {
  /// The widget to slide in
  final Widget child;

  /// Duration of the slide animation
  final Duration duration;

  /// Delay before starting the animation
  final Duration delay;

  /// Animation curve to control the timing function
  final Curve curve;

  /// Starting offset for the slide animation
  final Offset beginOffset;

  /// Creates a slide-in animation widget.
  ///
  /// The [child] parameter is required and represents the widget to animate.
  /// The [duration] controls how long the slide takes.
  /// The [delay] sets how long to wait before starting the animation.
  /// The [curve] determines the rate of change of the animation.
  /// The [beginOffset] sets the starting position relative to the final position.
  const SlideInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 350),
    this.delay = Duration.zero,
    this.curve = Curves.easeOutCubic,
    this.beginOffset = const Offset(0, 0.1),
  });

  @override
  State<SlideInAnimation> createState() => _SlideInAnimationState();
}

class _SlideInAnimationState extends State<SlideInAnimation>
    with SingleTickerProviderStateMixin, AutoDisposeAnimationControllerMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = createController(vsync: this, duration: widget.duration);
    _animation = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    // Delay the start of the animation if specified
    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _animation, child: widget.child);
  }
}

class ClassicSlideWithFadeInAnimation extends StatefulWidget {
  const ClassicSlideWithFadeInAnimation({
    super.key,
    required this.child,
    this.duration = AnimationDurations.medium,
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.beginOffset = const Offset(0, 0.2),
  });

  /// The widget to animate
  final Widget child;

  /// Duration of the slide animation
  final Duration duration;

  /// Delay before starting the animation
  final Duration delay;

  /// Animation curve to control the timing function
  final Curve curve;

  /// Starting offset for the slide animation
  final Offset beginOffset;

  @override
  State<ClassicSlideWithFadeInAnimation> createState() => _ClassicSlideWithFadeInAnimationState();
}

class _ClassicSlideWithFadeInAnimationState extends State<ClassicSlideWithFadeInAnimation> {
  @override
  Widget build(BuildContext context) {
    return SlideInAnimation(
      beginOffset: Offset(0, 0.2),
      curve: widget.curve,
      child: FadeInAnimation(curve: widget.curve, child: widget.child),
    );
  }
}

/// A widget that animates a list of children with a staggered timing effect.
///
/// Each child appears with a slight delay after the previous one, creating
/// a cascading animation effect that draws attention to the list items in sequence.
class StaggeredListAnimation extends StatefulWidget {
  /// The list of widgets to animate
  final List<Widget> children;

  /// Duration for each individual item's animation
  final Duration itemDuration;

  /// Initial delay before starting the first animation
  final Duration delay;

  /// Delay between each item's animation start
  final Duration staggerDuration;

  /// Animation curve to control the timing function
  final Curve curve;

  /// Direction of the stagger effect
  final Axis direction;

  /// Creates a staggered list animation widget.
  ///
  /// The [children] parameter is required and represents the widgets to animate.
  /// The [itemDuration] controls how long each item's animation takes.
  /// The [delay] sets how long to wait before starting the first animation.
  /// The [staggerDuration] controls the time between each item's animation start.
  /// The [curve] determines the rate of change of the animation.
  /// The [direction] determines whether the list is displayed vertically or horizontally.
  const StaggeredListAnimation({
    super.key,
    required this.children,
    this.itemDuration = const Duration(milliseconds: 350),
    this.delay = const Duration(milliseconds: 100),
    this.staggerDuration = const Duration(milliseconds: 50),
    this.curve = Curves.easeOutCubic,
    this.direction = Axis.vertical,
  });

  @override
  State<StaggeredListAnimation> createState() => _StaggeredListAnimationState();
}

class _StaggeredListAnimationState extends State<StaggeredListAnimation> {
  @override
  Widget build(BuildContext context) {
    final staggeredChildren = List.generate(widget.children.length, (index) {
      final itemDelay = widget.delay + (widget.staggerDuration * index);
      return FadeInAnimation(
        delay: itemDelay,
        duration: widget.itemDuration,
        curve: widget.curve,
        child: SlideInAnimation(
          delay: itemDelay,
          duration: widget.itemDuration,
          curve: widget.curve,
          beginOffset: const Offset(0, 0.1),
          child: widget.children[index],
        ),
      );
    });

    // Use Flex to support both vertical and horizontal layouts
    return Flex(
      direction: widget.direction,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: staggeredChildren,
    );
  }
}

/// A widget that creates a pulsing animation effect, ideal for drawing attention to UI elements.
///
/// This animation continuously cycles through three phases:
/// 1. Grow from normal size to [maxScale]
/// 2. Shrink from [maxScale] to [minScale]
/// 3. Return from [minScale] to normal size
///
/// The animation repeats indefinitely until the widget is disposed.
class PulseAnimation extends StatefulWidget {
  /// The widget to apply the pulsing animation to
  final Widget child;

  /// Duration for a complete pulse cycle
  final Duration duration;

  /// Animation curve to control the pulsing motion
  final Curve curve;

  /// Minimum scale factor (smallest size during pulse)
  final double minScale;

  /// Maximum scale factor (largest size during pulse)
  final double maxScale;

  /// Whether the animation should automatically start
  final bool autoStart;

  /// Creates a pulse animation widget.
  ///
  /// The [child] parameter is required and represents the widget to animate.
  /// The animation timing can be customized with [duration].
  /// The scale range is defined by [minScale] and [maxScale].
  /// Set [autoStart] to false if you want to manually control when the animation starts.
  const PulseAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.curve = Curves.easeInOut,
    this.minScale = 0.97,
    this.maxScale = 1.03,
    this.autoStart = true,
  });

  @override
  State<PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    // Create a more efficient animation sequence with proper weighting
    _animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: widget.maxScale,
        ).chain(CurveTween(curve: widget.curve)),
        weight: 33.3,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: widget.maxScale,
          end: widget.minScale,
        ).chain(CurveTween(curve: widget.curve)),
        weight: 33.3,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: widget.minScale,
          end: 1.0,
        ).chain(CurveTween(curve: widget.curve)),
        weight: 33.3,
      ),
    ]).animate(_controller);

    // Only start animation if autoStart is true
    if (widget.autoStart) {
      _controller.repeat();
    }
  }

  /// Manually start the pulsing animation
  void start() {
    if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  /// Manually stop the pulsing animation
  void stop() {
    if (_controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void didUpdateWidget(PulseAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle changes to animation properties
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }

    // Handle changes to autoStart
    if (!oldWidget.autoStart && widget.autoStart && !_controller.isAnimating) {
      _controller.repeat();
    } else if (oldWidget.autoStart && !widget.autoStart && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Transform.scale(scale: _animation.value, child: child),
      child: widget.child,
    );
  }
}

/// A progress bar that animates changes to its progress value.
///
/// This widget provides a simple way to display progress with a smooth animation
/// when the progress value changes. It's useful for loading indicators, completion
/// status, or any scenario where progress needs to be visualized.
class AnimatedProgressBar extends StatefulWidget {
  /// The current progress value between 0.0 and 1.0
  final double progress;

  /// Background color of the progress bar
  final Color backgroundColor;

  /// Color of the progress indicator
  final Color progressColor;

  /// Height of the progress bar
  final double height;

  /// Duration of the progress animation
  final Duration duration;

  /// Animation curve to control the timing function
  final Curve curve;

  /// Width constraint for the progress bar (null means parent width)
  final double? width;

  /// Creates an animated progress bar widget.
  ///
  /// The [progress] parameter is required and must be between 0.0 and 1.0.
  /// The [height] controls the thickness of the progress bar.
  /// The [backgroundColor] and [progressColor] control the appearance.
  /// The [duration] and [curve] control the animation behavior.
  /// The optional [width] parameter constrains the width of the progress bar.
  const AnimatedProgressBar({
    super.key,
    required this.progress,
    this.backgroundColor = const Color(0xFFE2E8F0),
    this.progressColor = const Color(0xFF4FD1C5),
    this.height = 8.0,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.width,
  }) : assert(progress >= 0.0 && progress <= 1.0, 'Progress must be between 0.0 and 1.0');

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar> {
  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder to get the available width if no width is specified
    return LayoutBuilder(
      builder: (context, constraints) {
        final containerWidth = widget.width ?? constraints.maxWidth;

        return Container(
          width: containerWidth,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.height / 2),
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: widget.duration,
                curve: widget.curve,
                width: containerWidth * widget.progress.clamp(0.0, 1.0),
                decoration: BoxDecoration(
                  color: widget.progressColor,
                  borderRadius: BorderRadius.circular(widget.height / 2),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// 6. Animated Card Flip (for before/after comparisons or revealing information)
class FlipCard extends StatefulWidget {
  /// The front face of the card
  final Widget front;

  /// The back face of the card
  final Widget back;

  /// Duration of the flip animation
  final Duration duration;

  /// Optional callback triggered when the card is flipped
  final VoidCallback? onFlip;

  /// Whether the card should start showing the front side
  final bool startWithFrontSide;

  /// Whether the card can be flipped by tapping
  final bool flipOnTap;

  /// Creates a flip card animation widget.
  ///
  /// The [front] and [back] parameters are required and represent the two sides of the card.
  /// The [duration] controls how long the flip animation takes.
  /// The [onFlip] callback is triggered when the card is flipped.
  /// Set [startWithFrontSide] to false to initially show the back side.
  /// Set [flipOnTap] to false to disable automatic flipping on tap.
  const FlipCard({
    super.key,
    required this.front,
    required this.back,
    this.duration = const Duration(milliseconds: 400),
    this.onFlip,
    this.startWithFrontSide = true,
    this.flipOnTap = true,
  });

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin, AutoDisposeAnimationControllerMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late bool _showFrontSide;

  @override
  void initState() {
    super.initState();
    _showFrontSide = widget.startWithFrontSide;
    _controller = createController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Initialize to back side if needed
    if (!_showFrontSide) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update controller duration if it changed
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
  }

  /// Toggles the card between front and back sides
  void _toggleCard() {
    if (_showFrontSide) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _showFrontSide = !_showFrontSide;
    if (widget.onFlip != null) {
      widget.onFlip!();
    }
  }

  /// Flips to the front side
  void flipToFront() {
    if (!_showFrontSide) {
      _toggleCard();
    }
  }

  /// Flips to the back side
  void flipToBack() {
    if (_showFrontSide) {
      _toggleCard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.flipOnTap ? _toggleCard : null,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          // Use more precise PI value for better animation
          const pi = 3.141592653589793;
          final angle = _animation.value * pi;

          // Only show front/back when they're actually visible to improve performance
          final showFront = _animation.value < 0.5;
          final showBack = _animation.value >= 0.5;

          // Calculate rotation for each side
          final frontRotation = showFront ? angle : 0.0;
          final backRotation = showBack ? angle + pi : pi;

          return Stack(
            children: [
              if (showFront)
                Transform(
                  transform:
                      Matrix4.identity()
                        ..setEntry(3, 2, 0.001) // Perspective
                        ..rotateY(frontRotation),
                  alignment: Alignment.center,
                  child: widget.front,
                ),
              if (showBack)
                Transform(
                  transform:
                      Matrix4.identity()
                        ..setEntry(3, 2, 0.001) // Perspective
                        ..rotateY(backRotation),
                  alignment: Alignment.center,
                  child: widget.back,
                ),
            ],
          );
        },
      ),
    );
  }
}

// 7. Animated Circular Progress Indicator (for workout timers, meditation sessions)
class AnimatedCircularProgress extends StatefulWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;
  final Widget? child;
  final Duration duration;
  final Curve curve;

  const AnimatedCircularProgress({
    super.key,
    required this.progress,
    this.size = 100.0,
    this.strokeWidth = 10.0,
    this.backgroundColor = const Color(0xFFE2E8F0),
    this.progressColor = const Color(0xFF4FD1C5),
    this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  @override
  State<AnimatedCircularProgress> createState() => _AnimatedCircularProgressState();
}

class _AnimatedCircularProgressState extends State<AnimatedCircularProgress> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        children: [
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: widget.strokeWidth,
              backgroundColor: widget.backgroundColor,
              valueColor: AlwaysStoppedAnimation<Color>(widget.backgroundColor),
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: widget.progress),
            duration: widget.duration,
            curve: widget.curve,
            builder: (context, value, _) {
              return SizedBox(
                width: widget.size,
                height: widget.size,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: widget.strokeWidth,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(widget.progressColor),
                ),
              );
            },
          ),
          if (widget.child != null)
            SizedBox(width: widget.size, height: widget.size, child: Center(child: widget.child)),
        ],
      ),
    );
  }
}

// 8. Animated Gradient Background (for meditation screens)
class AnimatedGradientBackground extends StatefulWidget {
  final List<List<Color>> colorSets;
  final Duration duration;
  final Widget child;

  const AnimatedGradientBackground({
    super.key,
    required this.colorSets,
    this.duration = const Duration(seconds: 5),
    required this.child,
  });

  @override
  State<AnimatedGradientBackground> createState() => _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late int _currentSet;
  late int _nextSet;

  @override
  void initState() {
    super.initState();
    _currentSet = 0;
    _nextSet = 1;
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _currentSet = _nextSet;
            _nextSet = (_nextSet + 1) % widget.colorSets.length;
            _controller.reset();
            _controller.forward();
          });
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(
                  widget.colorSets[_currentSet][0],
                  widget.colorSets[_nextSet][0],
                  _controller.value,
                )!,
                Color.lerp(
                  widget.colorSets[_currentSet][1],
                  widget.colorSets[_nextSet][1],
                  _controller.value,
                )!,
              ],
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// A widget that creates a breathing animation effect, ideal for meditation guidance.
///
/// This animation cycles through three phases:
/// 1. Expand - grows from [minScale] to [maxScale]
/// 2. Hold - maintains [maxScale] for [holdDuration]
/// 3. Contract - shrinks from [maxScale] to [minScale]
///
/// After completing a full cycle, it pauses briefly before starting again.
class BreathingAnimation extends StatefulWidget {
  /// The widget to apply the breathing animation to
  final Widget child;

  /// Duration for the expansion phase (inhale)
  final Duration expandDuration;

  /// Duration to hold at maximum scale (hold breath)
  final Duration holdDuration;

  /// Duration for the contraction phase (exhale)
  final Duration contractDuration;

  /// Minimum scale factor (starting and ending point)
  final double minScale;

  /// Maximum scale factor (fully expanded)
  final double maxScale;

  /// Creates a breathing animation widget.
  ///
  /// The [child] parameter is required and represents the widget to animate.
  /// The animation timing can be customized with [expandDuration], [holdDuration],
  /// and [contractDuration]. The scale range is defined by [minScale] and [maxScale].
  const BreathingAnimation({
    super.key,
    required this.child,
    this.expandDuration = const Duration(seconds: 4),
    this.holdDuration = const Duration(seconds: 2),
    this.contractDuration = const Duration(seconds: 4),
    this.minScale = 0.8,
    this.maxScale = 1.2,
  });

  @override
  State<BreathingAnimation> createState() => _BreathingAnimationState();
}

class _BreathingAnimationState extends State<BreathingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // Track the current phase of the breathing cycle
  _BreathingPhase _currentPhase = _BreathingPhase.expanding;

  @override
  void initState() {
    super.initState();

    // Use a single controller for the entire breathing cycle
    final totalDuration =
        widget.expandDuration +
        widget.holdDuration +
        widget.contractDuration +
        const Duration(milliseconds: 500);
    _controller = AnimationController(vsync: this, duration: totalDuration);

    // Create a sequence for the entire breathing cycle
    _animation = TweenSequence<double>([
      // Expand phase
      TweenSequenceItem(
        tween: Tween<double>(
          begin: widget.minScale,
          end: widget.maxScale,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: widget.expandDuration.inMilliseconds / totalDuration.inMilliseconds,
      ),
      // Hold phase
      TweenSequenceItem(
        tween: ConstantTween<double>(widget.maxScale),
        weight: widget.holdDuration.inMilliseconds / totalDuration.inMilliseconds,
      ),
      // Contract phase
      TweenSequenceItem(
        tween: Tween<double>(
          begin: widget.maxScale,
          end: widget.minScale,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: widget.contractDuration.inMilliseconds / totalDuration.inMilliseconds,
      ),
      // Pause phase
      TweenSequenceItem(
        tween: ConstantTween<double>(widget.minScale),
        weight: 500 / totalDuration.inMilliseconds,
      ),
    ]).animate(_controller);

    // Track the breathing phase for accessibility or external state monitoring
    _controller.addListener(() {
      final progress = _controller.value;
      final expandWeight = widget.expandDuration.inMilliseconds / totalDuration.inMilliseconds;
      final holdWeight = widget.holdDuration.inMilliseconds / totalDuration.inMilliseconds;
      final contractWeight = widget.contractDuration.inMilliseconds / totalDuration.inMilliseconds;

      if (progress < expandWeight) {
        _currentPhase = _BreathingPhase.expanding;
      } else if (progress < expandWeight + holdWeight) {
        _currentPhase = _BreathingPhase.holding;
      } else if (progress < expandWeight + holdWeight + contractWeight) {
        _currentPhase = _BreathingPhase.contracting;
      } else {
        _currentPhase = _BreathingPhase.pausing;
      }
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Transform.scale(scale: _animation.value, child: child),
      child: widget.child,
    );
  }
}

/// Represents the different phases of the breathing animation cycle.
enum _BreathingPhase { expanding, holding, contracting, pausing }

// 10. Example Usage - Animated Dashboard Card
class AnimatedDashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final LinearGradient gradient;
  final VoidCallback onTap;

  const AnimatedDashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SlideInAnimation(
      beginOffset: const Offset(0, 0.2),
      child: FadeInAnimation(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: Colors.white, size: 32),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
