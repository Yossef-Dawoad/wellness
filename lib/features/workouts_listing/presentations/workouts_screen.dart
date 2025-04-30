import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/core/common/widgets/pull_to_reveal.dart';
import 'package:wellness/features/workouts_listing/logic/bloc/exerices_bloc.dart';
import 'package:wellness/features/workouts_listing/datasources/exercices_service.dart';
import 'package:wellness/features/workouts_listing/datasources/exerice_repo.dart';
import 'package:wellness/features/workouts_listing/presentations/exercise_screen.dart';

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
  final _exericeBloc = ExericesBloc(ExericeRepository(exericeService: RapidAPIExerciseDB()));

  // list -> MuscleTypeChips -> when user click on type -> add to list
  // when list changes  -> call the api can get new data -> rebuild the list of exercie by type
  final List<ExericeType> types = [];

  @override
  void initState() {
    super.initState();
    _exericeBloc.add(ExericesTypesRequested());
  }

  @override
  void dispose() {
    _exericeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _exericeBloc,
      child: Scaffold(
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
                  Center(
                    child: Text(
                      'Workout of the day',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const WorkoutsDetailsSummary(),
                  const SizedBox(height: 16),
                  const MuscleTypeChips(),
                  const SizedBox(height: 16),
                  const Expanded(child: ExercisesByTypeListView()),
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
    final _exericeBloc = ExericesBloc(ExericeRepository(exericeService: RapidAPIExerciseDB()));

    return BlocProvider(
      create: (context) => _exericeBloc..add(ExericesTypesRequested()),
      child: BlocBuilder<ExericesBloc, ExericesState>(
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
      ),
    );
  }
}

class ExericeTypesView extends StatelessWidget {
  const ExericeTypesView({super.key, required this.types});
  final List<ExericeType> types;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: types.length,
        itemBuilder: (context, index) {
          final exericeType = types[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              // color: WidgetStatePropertyAll(),
              label: Text(exericeType.toValue()),
              selected: false,
              onSelected: (value) {
                //TODO: add bloc event to fetch exercises by type
                //TODO: the event may take more than one type
              },
            ),
          );
        },
      ),
    );
  }
}

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({super.key, required this.exercise});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      height: 100,
      child: Row(
        children: [
          Container(
            width: 100,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage('assets/images/chest.jpg'),
              //   fit: BoxFit.cover,
              // ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Image.network(exercise.gifUrl),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(exercise.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade100,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        exercise.target.name,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text('12 reps', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ExerciseScreen(),
            settings: RouteSettings(arguments: exercise)));
          }, icon: Icon(Icons.arrow_forward_ios, size: 14), ),
        ],
      ),
    );
  }
}
