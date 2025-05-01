import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../logic/bloc/exerices_bloc.dart';
import '../workouts_screen.dart';

class ExercisesByTypeListView extends StatelessWidget {
  const ExercisesByTypeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExericesBloc, ExericesState>(
      buildWhen:
          (previous, current) =>
              current is ExericesLoadedSuccess ||
              current is ExericesError ||
              current is ExericesLoadInProgress,
      builder: (context, state) {
        return switch (state) {
          ExericesLoadedSuccess(exercises: var exercises) => ListView.separated(
            itemCount: exercises.length,
            padding: const EdgeInsets.only(top: 8.0),
            separatorBuilder: (context, index) => const SizedBox(height: 8.0),
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return ExerciseTile(exercise: exercise, blocContext: context, exercises: state.exercises,index: index,);
            },
          ),
          ExericesError(message: var message) => Center(child: Text(message)),
          ExericesInitial() => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.images.onboarding.emptyStateSvg.svg(width: 120, height: 120),
              SizedBox(height: 16),
              Text('No exercises yet !!', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          ExericesLoadInProgress() => Center(child: CircularProgressIndicator()),
          _ => Center(child: Text('unknow state occurs')),
        };
      },
    );
  }
}
