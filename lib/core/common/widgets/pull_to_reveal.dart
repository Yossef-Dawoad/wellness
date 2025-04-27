import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A controller to programmatically interact with the [PersistentPullToReveal] widget.
class PersistentPullToRevealController extends ChangeNotifier {
  bool _isRevealed = false;
  bool _showRequestPending = false;
  bool _hideRequestPending = false;
  final ValueNotifier<bool> _isRevealedNotifier = ValueNotifier(false);

  ValueListenable<bool> get isRevealedListenable => _isRevealedNotifier;
  bool get isRevealed => _isRevealed;
  bool get showRequestPending => _showRequestPending;
  bool get hideRequestPending => _hideRequestPending;

  void show() {
    if (!_isRevealed) {
      _showRequestPending = true;
      _hideRequestPending = false;
      notifyListeners();
    }
  }

  void hide() {
    if (_isRevealed) {
      _hideRequestPending = true;
      _showRequestPending = false;
      notifyListeners();
    }
  }

  void consumeShowRequest() => _showRequestPending = false;
  void consumeHideRequest() => _hideRequestPending = false;

  void updateRevealState(bool revealed) {
    if (_isRevealed != revealed) {
      _isRevealed = revealed;
      _isRevealedNotifier.value = revealed;
    }
  }

  @override
  void dispose() {
    _isRevealedNotifier.dispose();
    super.dispose();
  }
}

/// A widget that reveals a persistent child upon pulling down, similar to RefreshIndicator
/// but doesn't require scrollable content.
class PersistentPullToReveal extends StatefulWidget {
  final Widget revealableWidget;
  final Widget child;
  final double revealableHeight;
  final double revealThreshold;
  final Duration animationDuration;
  final VoidCallback? onRevealed;
  final VoidCallback? onHidden;
  final PersistentPullToRevealController? controller;
  final double overdragFactor;

  const PersistentPullToReveal({
    super.key,
    required this.revealableWidget,
    required this.child,
    required this.revealableHeight,
    this.revealThreshold = 100.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.onRevealed,
    this.onHidden,
    this.controller,
    this.overdragFactor = 1.1,
  }) : assert(revealableHeight > 0, 'revealableHeight must be positive.'),
       assert(revealThreshold > 0, 'revealThreshold must be positive.'),
       assert(overdragFactor >= 1.0, 'overdragFactor must be >= 1.0.'),
       assert(
         revealThreshold <= revealableHeight,
         'revealThreshold should generally be less than or equal to revealableHeight.',
       );

  @override
  State<PersistentPullToReveal> createState() => _PersistentPullToRevealState();
}

class _PersistentPullToRevealState extends State<PersistentPullToReveal>
    with SingleTickerProviderStateMixin {
  late final ValueNotifier<bool> _isRevealedNotifier;
  final ValueNotifier<double> _dragOffsetNotifier = ValueNotifier(0.0);
  bool _isDragging = false;
  Offset _dragStartPosition = Offset.zero;

  // For direct gesture detection
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _isRevealedNotifier = ValueNotifier(widget.controller?.isRevealed ?? false);
    widget.controller?.updateRevealState(_isRevealedNotifier.value);
    widget.controller?.addListener(_handleControllerChange);
    _isRevealedNotifier.addListener(_onStateChange);

    _animationController = AnimationController(vsync: this, duration: widget.animationDuration);

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.revealableHeight,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic));

    _animation.addListener(() {
      _dragOffsetNotifier.value = _animation.value;
    });
  }

  @override
  void didUpdateWidget(PersistentPullToReveal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChange);
      widget.controller?.addListener(_handleControllerChange);
      widget.controller?.updateRevealState(_isRevealedNotifier.value);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChange);
    _isRevealedNotifier.removeListener(_onStateChange);
    _isRevealedNotifier.dispose();
    _dragOffsetNotifier.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onStateChange() => widget.controller?.updateRevealState(_isRevealedNotifier.value);

  void _handleControllerChange() {
    final controller = widget.controller;
    if (controller == null) return;

    if (controller.showRequestPending && !_isRevealedNotifier.value) {
      _showWidget();
      controller.consumeShowRequest();
    } else if (controller.hideRequestPending && _isRevealedNotifier.value) {
      _hideWidget();
      controller.consumeHideRequest();
    }
  }

  void _showWidget() {
    if (!_isRevealedNotifier.value) {
      _isRevealedNotifier.value = true;
      _animationController.forward();
      widget.onRevealed?.call();
    }
  }

  void _hideWidget() {
    if (_isRevealedNotifier.value) {
      _isRevealedNotifier.value = false;
      _animationController.reverse();
      widget.onHidden?.call();
    }
  }

  void _handleDragStart(DragStartDetails details) {
    _isDragging = true;
    _dragStartPosition = details.globalPosition;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;
  
    // Only respond to downward drags
    final delta = details.globalPosition.dy - _dragStartPosition.dy;
    if (delta <= 0 && _dragOffsetNotifier.value <= 0) {
      _isDragging = false;
      return;
    }
  
    if (!_isRevealedNotifier.value) {
      // Apply resistance using a dampening function
      // This creates a non-linear response that increases resistance as you pull further
      final dampening = 0.5 - 0.3 * (delta / (widget.revealableHeight * 3));
      final resistantDelta = delta * max(0.2, dampening);
      
      final dragAmount = max(0.0, resistantDelta);
      _dragOffsetNotifier.value = min(
        dragAmount,
        widget.revealableHeight * widget.overdragFactor,
      );
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!_isDragging) return;
    _isDragging = false;

    if (!_isRevealedNotifier.value) {
      if (_dragOffsetNotifier.value >= widget.revealThreshold) {
        _showWidget();
      } else if (_dragOffsetNotifier.value > 0) {
        _animationController.reverse();
        _dragOffsetNotifier.value = 0;
      }
    }
  }

  // This still handles scroll notifications for compatibility with scrollable content
  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth != 0 || notification.metrics.axis != Axis.vertical) {
      return false;
    }

    if (notification is ScrollStartNotification) {
      _isDragging = notification.metrics.pixels <= 0;
      if (_isDragging) {
        _dragStartPosition = Offset(0, notification.metrics.pixels);
      }
    } else if (notification is ScrollUpdateNotification) {
      if (_isDragging && !_isRevealedNotifier.value) {
        if (notification.metrics.pixels <= 0) {
          final rawDragAmount = -notification.metrics.pixels;
          
          // Apply resistance using a dampening function
          final dampening = 0.5 - 0.3 * (rawDragAmount / (widget.revealableHeight * 3));
          final resistantDragAmount = rawDragAmount * max(0.2, dampening);
          
          _dragOffsetNotifier.value = min(
            max(0.0, resistantDragAmount),
            widget.revealableHeight * widget.overdragFactor,
          );
        } else {
          _isDragging = false;
          if (_dragOffsetNotifier.value > 0) {
            _dragOffsetNotifier.value = 0;
          }
        }
      }
    } else if (notification is UserScrollNotification) {
      if (_isDragging) {
        final wasDragging = _isDragging;
        _isDragging = false;

        if (wasDragging && !_isRevealedNotifier.value) {
          if (_dragOffsetNotifier.value >= widget.revealThreshold) {
            _showWidget();
          } else if (_dragOffsetNotifier.value > 0) {
            _dragOffsetNotifier.value = 0;
          }
        }
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _dragOffsetNotifier,
      builder: (context, dragOffset, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: _isRevealedNotifier,
          builder: (context, isRevealed, _) {
            final visibleHeight = min(dragOffset, widget.revealableHeight);
            final double revealTopPosition =
                isRevealed ? 0.0 : -widget.revealableHeight + visibleHeight;
            final childTopPosition = isRevealed ? widget.revealableHeight : visibleHeight;
            final duration = _isDragging ? Duration.zero : widget.animationDuration;

            return Stack(
              children: [
                AnimatedPositioned(
                  duration: duration,
                  curve: Curves.easeOutCubic,
                  top: revealTopPosition,
                  left: 0,
                  right: 0,
                  height: widget.revealableHeight,
                  child: ClipRect(child: widget.revealableWidget),
                ),
                AnimatedPositioned(
                  duration: duration,
                  curve: Curves.easeOutCubic,
                  top: childTopPosition,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onVerticalDragStart: _handleDragStart,
                    onVerticalDragUpdate: _handleDragUpdate,
                    onVerticalDragEnd: _handleDragEnd,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: _handleScrollNotification,
                      child: widget.child,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
