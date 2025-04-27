import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/features/workouts_listing/datasources/exercices_service.dart';
import 'package:wellness/features/workouts_listing/logic/bloc/exerices_bloc.dart';

import '../datasources/exerice_repo.dart';
import 'components/exercises_by_type_listview.dart';

class ExerciseByTypeScreen extends StatelessWidget {
  const ExerciseByTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Full Body'), centerTitle: true),
      body: BlocProvider(
        create:
            (context) =>
                ExericesBloc(ExericeRepository(exericeService: RapidAPIExerciseDB()))
                  ..add(ExercisesByTypeRequested('cardio')),
        child: ExercisesByTypeListView(),
      ),
    );
  }
}
