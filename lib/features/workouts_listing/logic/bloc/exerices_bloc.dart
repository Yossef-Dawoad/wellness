import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:wellness/features/workouts_listing/datasources/exerice_repo.dart';

import '../../datasources/exercice_model.dart';

part 'exerices_event.dart';
part 'exerices_state.dart';

class ExericesBloc extends Bloc<ExericesEvent, ExericesState> {
  final ExericeRepository _exericeRepository;

  final List<ExericeType> _types = [];
  // final Map<String, List<Exercise>> _cachedExercises = {};

  ExericesBloc(this._exericeRepository) : super(ExericesInitial()) {
    // Remove the general handler that was causing the issue
    // on<ExericesEvent>((event, emit) => emit(ExericesTypeLoadInProgress()));
    
    on<ExericesTypesRequested>(_onExerciceTypesRequested);
    on<ExercisesByTypeRequested>(_onExerciceTypeSelected);
    on<FetchExercisesByName>(_onFetchExerciseByName);
  }

  FutureOr<void> _onExerciceTypesRequested(
    ExericesTypesRequested event,
    Emitter<ExericesState> emit,
  ) async {
    // Emit loading state only for this specific event
    emit(ExericesTypeLoadInProgress());
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
    // Create a new state for exercises loading that doesn't affect the types view
    emit(ExericesLoadInProgress());
    try {
      final exercises = await _exericeRepository.getExercisesByType(event.type);
      print(exercises.first);
      emit(ExericesLoadedSuccess(exercises: exercises));
    } catch (e) {
      emit(ExericesError(message: e.toString()));
    }
  }

  Future<void> _onFetchExerciseByName(
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
