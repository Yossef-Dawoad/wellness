import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/services/local_database/shared_pref/shared_pref_helper.dart';
import '../../../../core/service_locator/sl.dart';
import 'package:wellness/features/user_questionnaire/data/user_questionaire_keys.dart';
import '../../models/user_model.dart';
import 'calories_state.dart';

class CaloriesCubit extends Cubit<CaloriesState> {
  CaloriesCubit() : super(CaloriesInitial());

  FutureOr<void> calculate() async {
    final userWeight = await sl<SharedPrefHelper>().getValue<double>(UserQuestionaireKeys.weight);
    final userHeight = await sl<SharedPrefHelper>().getValue<double>(UserQuestionaireKeys.height);
    final userAge = await sl<SharedPrefHelper>().getValue<int>(UserQuestionaireKeys.age);
    final userGender = await sl<SharedPrefHelper>().getValue<int>(UserQuestionaireKeys.gender);
    final userGoalIndex = await sl<SharedPrefHelper>().getValue<int>(UserQuestionaireKeys.goal);
    final userActivityLevel = await sl<SharedPrefHelper>().getValue<int>(
      UserQuestionaireKeys.activity,
    );
    final user = User(
      weight: userWeight ?? 70,
      height: userHeight ?? 65,
      age: userAge ?? 25,
      gendertype: (userGender == null && userGender == 1) ? 'Male' : 'Female',
      goalIndex: userGoalIndex ?? 0,
      activityLevel: userActivityLevel ?? 0,
    );
    emit(CaloriesLoading());

    final calories = user.goal_calculate();
    final protein = user.proteins_Calculate();
    final carbs = user.carbs_Calculate();
    final fats = user.fats_Calculate();

    emit(CaloriesLoaded(calories: calories, protein: protein, carbs: carbs, fats: fats));
  }
}
