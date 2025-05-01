import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/features/workouts_listing/datasources/exercice_model.dart';
import 'package:wellness/features/workouts_listing/logic/bloc/exerices_bloc.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({
    super.key,
    required this.exercises,
    required this.currentIndex,
    required this.exerciseBloc,
  });

  final List<Exercise> exercises;
  final int currentIndex;
  final ExericesBloc exerciseBloc;

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  // Exercise data
  String? exerciseName;
  bool _hasFetched = false;

  // Stopwatch state
  final StopwatchController _stopwatchController = StopwatchController();

  // Rest timer state
  final RestTimerController _restTimerController = RestTimerController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchExerciseData();
  }

  void _fetchExerciseData() {
    if (!_hasFetched) {
      exerciseName = widget.exercises[widget.currentIndex].name;
      if (exerciseName != null) {
        widget.exerciseBloc.add(FetchExercisesByName(exerciseName!));
        _hasFetched = true;
      }
    }
  }

  @override
  void dispose() {
    _stopwatchController.dispose();
    _restTimerController.dispose();
    super.dispose();
  }

  void _moveToNextExercise() {
    final nextIndex = widget.currentIndex + 1;
    if (nextIndex < widget.exercises.length) {
      _navigateToExercise(nextIndex);
    } else {
      Navigator.pop(context);
    }
  }

  void _moveToPreviousExercise() {
    final prevIndex = widget.currentIndex - 1;
    if (prevIndex >= 0) {
      _navigateToExercise(prevIndex);
    } else {
      Navigator.pop(context);
    }
  }

  void _navigateToExercise(int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) => BlocProvider.value(
              value: widget.exerciseBloc,
              child: ExerciseScreen(
                exercises: widget.exercises,
                currentIndex: index,
                exerciseBloc: widget.exerciseBloc,
              ),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final exerciseName = widget.exercises[widget.currentIndex].name;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise', style: TextStyle(fontWeight: FontWeight.w600)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<ExericesBloc, ExericesState>(
        buildWhen:
            (previous, current) =>
                current is FetchExerciseByNameLoadInSuccess ||
                current is ExericesError ||
                current is FetchExerciseByNameLoadInProgress,
        builder: (context, state) {
          if (state is FetchExerciseByNameLoadInProgress) {
            return const LoadingView();
          } else if (state is ExericesError) {
            return ErrorView(message: state.message);
          } else if (state is FetchExerciseByNameLoadInSuccess) {
            return ExerciseContentView(
              exercise: state.exerciseByName.first,
              stopwatchController: _stopwatchController,
              restTimerController: _restTimerController,
              onNextExercise: _moveToNextExercise,
              onPreviousExercise: _moveToPreviousExercise,
            );
          } else {
            return const UnexpectedStateView();
          }
        },
      ),
    );
  }
}

// MARK: - Controller Classes

class StopwatchController {
  Timer? _stopWatch;
  int _elapsedMilliseconds = 0;
  bool _isRunning = false;

  bool get isRunning => _isRunning;
  int get elapsedMilliseconds => _elapsedMilliseconds;

  String get formattedTime {
    final minutes = (_elapsedMilliseconds ~/ 1000) ~/ 60;
    final seconds = (_elapsedMilliseconds ~/ 1000) % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void start(VoidCallback onTick) {
    if (!_isRunning) {
      _isRunning = true;
      _stopWatch = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        _elapsedMilliseconds += 100;
        onTick();
      });
    }
  }

  void stop() {
    if (_isRunning) {
      _isRunning = false;
      _stopWatch?.cancel();
    }
  }

  void dispose() {
    _stopWatch?.cancel();
  }
}

class RestTimerController {
  Timer? _timer;
  int _remainingSeconds = 60; // Default: 1 minute
  int _initialSeconds = 60;
  bool _isRunning = false;

  // Rest period options (1 to 5 minutes in seconds)
  final List<int> restPeriodOptions = [60, 120, 180, 240, 300];

  bool get isRunning => _isRunning;
  int get remainingSeconds => _remainingSeconds;
  int get initialSeconds => _initialSeconds;
  double get progress => _remainingSeconds / _initialSeconds;

  String get formattedTime {
    final minutes = (_remainingSeconds ~/ 60);
    final seconds = (_remainingSeconds % 60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void setDuration(int durationInSeconds) {
    _timer?.cancel();
    _isRunning = false;
    _remainingSeconds = durationInSeconds;
    _initialSeconds = durationInSeconds;
  }

  void start(VoidCallback onTick, VoidCallback onComplete) {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_remainingSeconds > 0) {
          _remainingSeconds -= 1;
          onTick();
        } else {
          _timer?.cancel();
          _isRunning = false;
          onComplete();
        }
      });
    }
  }

  void pause() {
    if (_isRunning) {
      _isRunning = false;
      _timer?.cancel();
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}

// MARK: - Modular UI Components

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class ErrorView extends StatelessWidget {
  final String message;

  const ErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text('Error: $message', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }
}

class UnexpectedStateView extends StatelessWidget {
  const UnexpectedStateView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Unexpected state', style: TextStyle(fontSize: 16)));
  }
}

class ExerciseContentView extends StatefulWidget {
  final Exercise exercise;
  final StopwatchController stopwatchController;
  final RestTimerController restTimerController;
  final VoidCallback onNextExercise;
  final VoidCallback onPreviousExercise;

  const ExerciseContentView({
    super.key,
    required this.exercise,
    required this.stopwatchController,
    required this.restTimerController,
    required this.onNextExercise,
    required this.onPreviousExercise,
  });

  @override
  State<ExerciseContentView> createState() => _ExerciseContentViewState();
}

class _ExerciseContentViewState extends State<ExerciseContentView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
          child: Column(
            children: [
              StopwatchDisplay(controller: widget.stopwatchController),
              const SizedBox(height: 16),
              ExerciseImageView(imageUrl: widget.exercise.gifUrl),
              const SizedBox(height: 16),
              ExerciseInfoBar(exercise: widget.exercise),
              const SizedBox(height: 16),
              // Rest Timer Widget moved here, directly under the exercise name
              RestTimerWidget(
                controller: widget.restTimerController,
                onComplete: widget.onNextExercise,
                onTap: _handleRestTimerToggle,
              ),
              const SizedBox(height: 24),
              NavigationButtons(
                onPrevious: widget.onPreviousExercise,
                onStartStop: () => _handleStopwatchToggle(),
                isRunning: widget.stopwatchController.isRunning,
              ),
              const SizedBox(height: 12),
              BottomActionBar(
                restTimerController: widget.restTimerController,
                onSkipRest: widget.onNextExercise,
              ),
              const SizedBox(height: 16), // Add bottom padding
            ],
          ),
        ),
      ),
    );
  }

  void _handleStopwatchToggle() {
    setState(() {
      if (widget.stopwatchController.isRunning) {
        widget.stopwatchController.stop();
      } else {
        widget.stopwatchController.start(() => setState(() {}));
      }
    });
  }

  void _handleRestTimerToggle() {
    setState(() {
      if (widget.restTimerController.isRunning) {
        widget.restTimerController.pause();
      } else {
        widget.stopwatchController.stop();
        widget.restTimerController.start(() => setState(() {}), widget.onNextExercise);
      }
    });
  }
}

class StopwatchDisplay extends StatelessWidget {
  final StopwatchController controller;

  const StopwatchDisplay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Text(
      controller.formattedTime,
      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.5),
    );
  }
}

class ExerciseImageView extends StatelessWidget {
  final String imageUrl;

  const ExerciseImageView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value:
                  loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Icon(Icons.image_not_supported, size: 48, color: Colors.grey));
        },
      ),
    );
  }
}

class ExerciseInfoBar extends StatelessWidget {
  final Exercise exercise;

  const ExerciseInfoBar({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            exercise.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          onPressed: () => _showInstructionsDialog(context),
          icon: const Icon(Icons.info_outline, color: Colors.blue),
          tooltip: 'Instructions',
        ),
      ],
    );
  }

  void _showInstructionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(exercise.name),
            content: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
                minWidth: 280,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
              ),
              child: InstructionsList(instructions: exercise.instructions),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
            ],
          ),
    );
  }
}

class InstructionsList extends StatelessWidget {
  final List<String> instructions;

  const InstructionsList({super.key, required this.instructions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: instructions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${index + 1}. ', style: const TextStyle(fontWeight: FontWeight.bold)),
              Expanded(child: Text(instructions[index])),
            ],
          ),
        );
      },
    );
  }
}

class NavigationButtons extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onStartStop;
  final bool isRunning;

  const NavigationButtons({
    super.key,
    required this.onPrevious,
    required this.onStartStop,
    required this.isRunning,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ActionButton(onPressed: onPrevious, icon: Icons.arrow_back, label: 'Previous'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ActionButton(
            onPressed: onStartStop,
            icon: isRunning ? Icons.pause : Icons.play_arrow,
            label: isRunning ? 'Pause' : 'Start',
            color: isRunning ? Colors.orange : Colors.green,
          ),
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color? color;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.black87,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class RestTimerWidget extends StatelessWidget {
  final RestTimerController controller;
  final VoidCallback onComplete;
  final VoidCallback onTap;

  const RestTimerWidget({
    super.key,
    required this.controller,
    required this.onComplete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[100]),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 100, // Reduced from 120
              height: 100, // Reduced from 120
              child: CircularProgressIndicator(
                value: controller.progress,
                strokeWidth: 6, // Reduced from 8
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  controller.isRunning ? Colors.blue : Colors.grey,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Rest',
                  style: TextStyle(
                    fontSize: 14, // Reduced from 16
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 2), // Reduced from 4
                Text(
                  controller.formattedTime,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ), // Reduced from 24
                ),
                const SizedBox(height: 2), // Reduced from 4
                Text(
                  controller.isRunning ? 'Tap to pause' : 'Tap to start',
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]), // Reduced from 12
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BottomActionBar extends StatelessWidget {
  final RestTimerController restTimerController;
  final VoidCallback onSkipRest;

  const BottomActionBar({super.key, required this.restTimerController, required this.onSkipRest});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: RestDurationSelector(controller: restTimerController)),
        const SizedBox(width: 16),
        Expanded(
          child: ActionButton(onPressed: onSkipRest, icon: Icons.skip_next, label: 'Skip Rest'),
        ),
      ],
    );
  }
}

class RestDurationSelector extends StatelessWidget {
  final RestTimerController controller;

  const RestDurationSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34, // Fixed height for consistency
      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12), // Added horizontal padding
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            borderRadius: BorderRadius.circular(12),
            dropdownColor: Colors.black87,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            style: const TextStyle(color: Colors.white),
            value: controller.initialSeconds,
            isExpanded: true,
            alignment: Alignment.center,
            padding: EdgeInsets.zero, // Remove default padding
            items:
                controller.restPeriodOptions.map((int seconds) {
                  final minutes = seconds ~/ 60;
                  return DropdownMenuItem<int>(
                    value: seconds,
                    child: Center(
                      child: Text(
                        '$minutes min',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
            onChanged: (int? newValue) {
              if (newValue != null) {
                controller.setDuration(newValue);
              }
            },
          ),
        ),
      ),
    );
  }
}
