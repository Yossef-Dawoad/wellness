import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:wellness/features/workouts_listing/datasources/exerice_repo.dart';

import '../../../user_questionnaire/data/exercise_type_model.dart';
import '../../datasources/exercice_model.dart';

part 'exerices_event.dart';
part 'exerices_state.dart';

class ExericesBloc extends Bloc<ExericesEvent, ExericesState> {
  final ExericeRepository _exericeRepository;

  final List<ExericeType> _types = [];
  // final Map<String, List<Exercise>> _cachedExercises = {};

  ExericesBloc(this._exericeRepository) : super(ExericesInitial()) {
    on<ExericesEvent>((event, emit) => emit(ExericesTypeLoadInProgress()));
    on<ExericesTypesRequested>(_onExerciceTypesRequested);
    on<ExercisesByTypeRequested>(_onExerciceTypeSelected);
  }

  FutureOr<void> _onExerciceTypesRequested(
    ExericesTypesRequested event,
    Emitter<ExericesState> emit,
  ) async {
    try {
      final types = await _exericeRepository.getAllExercicesTypes();
      _types.addAll(types);
      emit(ExericesTypesLoadedSuccess(types: types));
    } catch (e) {
      emit(ExericesError(message: e.toString()));
    }
  }

  FutureOr<void> _onExerciceTypeSelected(
    ExercisesByTypeRequested event,
    Emitter<ExericesState> emit,
  ) async {
    try {
      final exercises = await _exericeRepository.getExercisesByType(event.type);
      print(exercises);
      emit(ExericesLoadedSuccess(exercises: exercises));
    } catch (e) {
      emit(ExericesError(message: e.toString()));
    }
  }

  Future<void> _onFetchExerciesByName(
    FetchExercisesByName event,
    Emitter<ExericesState> emit,
  ) async {
    try {
      emit(FetchExerciseByNameLoadInProgress());
      final exercise = await _exericeRepository.getExercisesByName(event.exerciseName);
      print(exercise);
      emit(FetchExerciseByNameLoadInSuccess(exerciseByName: exercise));
    } catch (e) {
      emit(ExericesError(message: e.toString()));
    }
  }
}
