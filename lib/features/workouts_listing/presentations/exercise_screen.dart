import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/features/workouts_listing/datasources/exercice_model.dart';
import 'package:wellness/features/workouts_listing/logic/bloc/exerices_bloc.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key, required this.exercises, required this.currentIndex, required this.exerciseBloc});

  final List<Exercise> exercises;
  final int currentIndex;
  final ExericesBloc exerciseBloc;

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  String? exerciseName;
  bool _hasFetched = false; // Flag to ensure the event is dispatched only once
//stopwatch variables
  Timer? _stopWatch;
  int _elapsedMilliseconds = 0;
  bool _isStopWatchRunning = false;

  //Timer variables
  // Timer variables (for rest period countdown)
  Timer? _timer;
  int _remainingSeconds = 60; // Default rest period: 1 minute
  int _initialSeconds = 60; // Store the initial duration for reset
  bool _isTimerRunning = false;
  // Rest period options (1 to 5 minutes in seconds)
  final List<int> _restPeriodOptions = [60, 120, 180, 240, 300];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Extract the exercise name from the route arguments
    if (!_hasFetched) {
      exerciseName = widget.exercises[widget.currentIndex].name;
      if (exerciseName != null) {
        // Dispatch the FetchExercisesByName event
        widget.exerciseBloc.add(FetchExercisesByName(exerciseName!));
        _hasFetched = true; // Prevent dispatching the event again
      }
    }
  }

  @override
  void dispose() {
    _stopWatch?.cancel();
    _timer?.cancel();
    super.dispose();
  }

  void _startStopwatch() {
    if (!_isStopWatchRunning) {
      _isStopWatchRunning = true;
      _stopWatch = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        setState(() {
          _elapsedMilliseconds += 100;
        });
      });
    }
  }

  void _stopStopwatch() {
    if (_isStopWatchRunning) {
      _isStopWatchRunning = false;
      _stopWatch?.cancel();
    }
  }

  //Timer methods
  void _setRestPeriod(int durationInSeconds) {
    setState(() {
      _timer?.cancel();
      _isTimerRunning = false;
      _remainingSeconds = durationInSeconds;
      _initialSeconds = durationInSeconds;
    });
  }

  void _startTimer() {
    if (!_isTimerRunning) {
      _stopStopwatch();
      _isTimerRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_remainingSeconds > 0) {
            _remainingSeconds -= 1;
          } else {
            _timer?.cancel();
            _isTimerRunning = false;
            _moveToNextExercise();
          }
        });
      });
    }
  }

  void _pauseTimer() {
    if (_isTimerRunning) {
      _isTimerRunning = false;
      _timer?.cancel();
      setState(() {});
    }
  }

  void _moveToNextExercise() {
    final nextIndex = widget.currentIndex + 1;
    if (nextIndex < widget.exercises.length) {
      // Navigate to the next exercise
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: widget.exerciseBloc,
            child: ExerciseScreen(
              exercises: widget.exercises,
              currentIndex: nextIndex,
              exerciseBloc: widget.exerciseBloc,
            ),
          ),
        ),
      );
    } else {
      // If there are no more exercises, go back to WorkoutsScreen
      Navigator.pop(context);
    }
  }
  void _moveToPreviousExercise() {
    final prevIndex = widget.currentIndex -1 ;
    if (prevIndex >= 0) {
      // Navigate to the next exercise
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: widget.exerciseBloc,
            child: ExerciseScreen(
              exercises: widget.exercises,
              currentIndex: prevIndex,
              exerciseBloc: widget.exerciseBloc,
            ),
          ),
        ),
      );
    } else {
      // If there are no more exercises, go back to WorkoutsScreen
      Navigator.pop(context);
    }
  }

  

  
  @override
  Widget build(BuildContext context) {
    // Extract the exercise name again for the null check (since we can't use initState for rendering logic)
    final exerciseName = widget.exercises[widget.currentIndex].name;
    // context.read<ExericesBloc>().add(FetchExercisesByName(exerciseName!));

    // Format the elapsed time as mm:ss
    final minutes = (_elapsedMilliseconds ~/ 1000) ~/ 60;
    final seconds = (_elapsedMilliseconds ~/ 1000) % 60;
    final formattedTime = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise'),
      ),
      body: BlocBuilder<ExericesBloc, ExericesState>(
        buildWhen: (previous, current) => 
              current is FetchExerciseByNameLoadInSuccess ||
              current is ExericesError ||
              current is FetchExerciseByNameLoadInProgress,
        builder: (context, state){
          if (state is FetchExerciseByNameLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if(state is ExericesError){
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is FetchExerciseByNameLoadInSuccess) {
            final exerciseByName = state.exerciseByName.first;
          
          return SafeArea(child: 
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
        child: Column(
          children: [
            //StopWatch UI
            Text(formattedTime, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Image.network(
              exerciseByName.gifUrl,
              height: 250,
              width: double.infinity,
            ),
            // Placeholder(),
            //Buttons
            
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7,),
                    child: Text(exerciseByName.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),maxLines: 3,softWrap: true,overflow: TextOverflow.ellipsis,)),
                      
                      IconButton(onPressed: (){
                        showDialog(
                          context: context,
                          
                          builder: (context) => AlertDialog(

                            title: Text(exerciseName),
                            content: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height * 0.4,
                                        minWidth: 280,
                                        maxWidth: MediaQuery.of(context).size.width * 0.9,
                              ),
                              child: ListView.builder(
                                  itemCount: exerciseByName.instructions.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text('${index+1}- ${exerciseByName.instructions[index]}', maxLines: 2,),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      }, icon: Icon(Icons.error, color: Colors.blue,))
                ],
              ),
            ),
      
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(onPressed: _moveToPreviousExercise, child: Icon(Icons.arrow_back, color: Colors.white,size: 24,), style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black45,
                      minimumSize: Size(MediaQuery.of(context).size.width/2, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      )
                    ),),
                  ),
                ),
            
                Expanded(
                  child: Padding(
                    padding:  EdgeInsets.only(left: 10.0),
                    child: ElevatedButton(
                      onPressed: _isStopWatchRunning ? _stopStopwatch : _startStopwatch,
                       style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black45,
                      minimumSize: Size(MediaQuery.of(context).size.width/2, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      )
                    ),
                       child: Icon(_isStopWatchRunning ? Icons.pause : Icons.stop, color: Colors.white,size: 24,),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24,),

            InkWell(
              onTap: _isTimerRunning ? _pauseTimer : _startTimer,
              borderRadius: BorderRadius.circular(50),
              child: Stack(
                
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: CircularProgressIndicator(
                                  value: _remainingSeconds / _initialSeconds, // Progress (0.0 to 1.0)
                                  strokeWidth: 10,
                                  backgroundColor: Colors.grey[300],
                                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                                ),
                              ),
                              Column(
                                children: [
                                  Text('Rest'),
                                  Text(
                                    '${(_remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(_remainingSeconds % 60).toString().padLeft(2, '0')}',
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
            ),
      
            Spacer(),

            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black45,
                          minimumSize: Size(MediaQuery.of(context).size.width/2, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                          )
                        ), child: DropdownButton<int>(
                            borderRadius: BorderRadius.circular(10),
                            
                            // icon: Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.white,),
                            dropdownColor: Colors.black,
                            style: TextStyle(color: Colors.white, ),

                                  value: _initialSeconds,
                                  items: _restPeriodOptions.map((int seconds) {
                                    final minutes = seconds ~/ 60;
                                    return DropdownMenuItem<int>(
                                      value: seconds,
                                      child: Text('$minutes min',style: TextStyle(color: Colors.white),),
                                    );
                                  }).toList(),
                                  onChanged: (int? newValue) {
                                    if (newValue != null) {
                                      _setRestPeriod(newValue);
                                    }
                                  },
                                ),),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ElevatedButton(onPressed: _moveToNextExercise, style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black45,
                          minimumSize: Size(MediaQuery.of(context).size.width/2, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                          )
                        ), child: Text('Skip Rest', style: TextStyle(color: Colors.white,),),),
                  ),
                ),
              ],
            ),
      
            
          ],
        ),
      ),
      
      );
        } else{
          return const Center(child: Text('Unexpected state.'));
        }
        }
      ),
    );
  }
}

