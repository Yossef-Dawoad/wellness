part of 'exerices_bloc.dart';

@immutable
sealed class ExericesState extends Equatable {
  const ExericesState();

  @override
  List<Object?> get props => [];
}

final class ExericesInitial extends ExericesState {}

final class ExericesTypeLoadInProgress extends ExericesState {}

final class ExericesLoadInProgress extends ExericesState {}

final class ExericesTypesLoadedSuccess extends ExericesState {
  final List<ExericeType> types;
  const ExericesTypesLoadedSuccess({required this.types});

  @override
  List<Object?> get props => [types];
}

final class ExericesLoadedSuccess extends ExericesState {
  final List<Exercise> exercises;
  const ExericesLoadedSuccess({required this.exercises});
  @override
  List<Object?> get props => [exercises];
}

final class ExericesError extends ExericesState {
  final String message;

  const ExericesError({required this.message});
}

//////
///

final class FetchExerciseByNameLoadInProgress extends ExericesState {}
final class FetchExerciseByNameLoadInSuccess extends ExericesState {
  final List<Exercise> exerciseByName;

  const FetchExerciseByNameLoadInSuccess({required this.exerciseByName});

  @override
  List<Object?> get props => [exerciseByName];
  
}
