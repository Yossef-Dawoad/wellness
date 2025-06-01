import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/core/common/widgets/pull_to_reveal.dart';
import 'package:wellness/features/workouts_listing/logic/bloc/exerices_bloc.dart';
import 'package:wellness/features/workouts_listing/presentations/exercise_screen.dart';

import '../../../core/service_locator/sl.dart';
import '../datasources/exercice_model.dart';
import 'components/exercises_by_type_listview.dart';
import 'widgets/workout_details_summary.dart';

// TODO: add the general padding to design guide

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  final pullToRevealCtrl = PersistentPullToRevealController();

  // list -> MuscleTypeChips -> when user click on type -> add to list
  // when list changes  -> call the api can get new data -> rebuild the list of exercie by type
  final List<ExericeType> types = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ExericesBloc>()..add(ExericesTypesRequested()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Workout of the day',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: PersistentPullToReveal(
          controller: pullToRevealCtrl,
          revealableHeight: MediaQuery.sizeOf(context).height * 0.45,
          onRevealed: () => debugPrint("Panel Revealed!"),
          onHidden: () => debugPrint("Panel Hidden!"),
          revealableWidget: Container(
            color: Colors.teal,
            height: MediaQuery.sizeOf(context).height * 0.45,
            child: Center(
              child: ElevatedButton(onPressed: pullToRevealCtrl.hide, child: Text('Hide')),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const WorkoutsDetailsSummary(),
                  const SizedBox(height: 16),
                  const MuscleTypeChips(),
                  const SizedBox(height: 16),
                  Expanded(child: ExercisesByTypeListView()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MuscleTypeChips extends StatefulWidget {
  const MuscleTypeChips({super.key});

  @override
  State<MuscleTypeChips> createState() => _MuscleTypeChipsState();
}

class _MuscleTypeChipsState extends State<MuscleTypeChips> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExericesBloc, ExericesState>(
      buildWhen:
          (previous, current) =>
              current is ExericesTypesLoadedSuccess ||
              current is ExericesError ||
              current is ExericesTypeLoadInProgress,
      builder: (context, state) {
        return switch (state) {
          ExericesInitial() => Center(child: Text('Initial state')),
          ExericesTypeLoadInProgress() => Center(child: CircularProgressIndicator()),
          ExericesError() => Center(child: Text('Something went wrong')),
          ExericesTypesLoadedSuccess(types: var exericesTypes) => ExericeTypesView(
            types: exericesTypes,
          ),
          _ => Center(child: Text('unknow state occurs')),
        };
      },
    );
  }
}

class ExericeTypesView extends StatefulWidget {
  const ExericeTypesView({super.key, required this.types});
  final List<ExericeType> types;

  @override
  State<ExericeTypesView> createState() => _ExericeTypesViewState();
}

class _ExericeTypesViewState extends State<ExericeTypesView> {
  final List<ExericeType> selectedTypes = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.types.length,
        itemBuilder: (context, index) {
          final exericeType = widget.types[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              // color: WidgetStatePropertyAll(),
              label: Text(exericeType.toValue()),
              selected: false,
              onSelected: (value) {
                //TODO: add bloc event to fetch exercises by type
                //TODO: the event may take more than one type
                if (selectedTypes.contains(exericeType)) {
                  selectedTypes.remove(exericeType);
                } else {
                  selectedTypes.add(exericeType);
                }

                context.read<ExericesBloc>().add(ExercisesByTypeRequested(exericeType.toValue()));
              },
            ),
          );
        },
      ),
    );
  }
}

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({super.key, required this.exercise, required this.blocContext, required this.exercises, required this.index});

  final Exercise exercise;
  final BuildContext blocContext; // Add a BuildContext parameter to access the bloc
  final List<Exercise> exercises; // List of all exercises
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      height: 120,
      child: Row(
        children: [
          Container(
            width: 100,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
            child: Image.network(exercise.gifUrl),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  exercise.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  softWrap: true,
                  maxLines: 2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade100,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        exercise.target.toValue(),
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text('12 reps', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          // Spacer(),
          IconButton(
            onPressed: () {
                    // Use BlocProvider.value to provide the existing ExercisesBloc
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: blocContext.read<ExericesBloc>(),
                          child:  ExerciseScreen(
                            exercises: exercises, // Pass the list of exercises
                            currentIndex: index,
                            exerciseBloc: blocContext.read<ExericesBloc>(),
                          ),
                        ),
                        // settings: RouteSettings(arguments: exercise.name),
                      ),
                    );
                  },
          icon: Icon(Icons.arrow_forward_ios, size: 24), ),
        ],
      ),
    );
  }
}
