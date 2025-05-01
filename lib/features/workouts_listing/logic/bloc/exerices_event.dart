part of 'exerices_bloc.dart';

@immutable
sealed class ExericesEvent extends Equatable {
  const ExericesEvent();
  @override
  List<Object?> get props => [];
}

class ExericesTypesRequested extends ExericesEvent {
  const ExericesTypesRequested();
}

class ExercisesByTypeRequested extends ExericesEvent {
  final String type;

  const ExercisesByTypeRequested(this.type);

  @override
  List<Object> get props => [type];
}

class ExerciseTypeCleared extends ExericesEvent {
  const ExerciseTypeCleared();
}

// Internal events - for bloc use only
class _LoadExerices extends ExericesEvent {
  final bool forceReload;

  const _LoadExerices({this.forceReload = false});

  @override
  List<Object> get props => [forceReload];
}


class FetchExercisesByName extends ExericesEvent {
  final String exerciseName;

  const FetchExercisesByName(this.exerciseName);

  @override
  List<Object> get props => [exerciseName];
}
