import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellness/core/common/services/local_database/shared_pref/shared_pref_helper.dart';
import 'package:wellness/features/login/data/repo/login_repo.dart';
import 'package:wellness/features/login/logic/cubit/login_cubit.dart';
import 'package:wellness/features/workouts_listing/datasources/exercices_service.dart';
import 'package:wellness/features/workouts_listing/datasources/exerice_repo.dart';
import 'package:wellness/features/workouts_listing/logic/bloc/exerices_bloc.dart';

import '../../features/register/data/repo/register_repo.dart';
import '../../features/register/logic/cubit/register_cubit.dart';
import '../networking/weger_api/api_service.dart';
import '../networking/weger_api/dio_factory.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> setupLocator() async {
  // --- Core Services ---
  // Lazy Singleton: Created only when first requested, then reused. Good for services not needed immediately.
  // sl.registerLazySingleton<http.Client>(() => http.Client());
  // sl.registerLazySingleton<ApiClient>(() => ApiClient(httpClient: sl())); // Depends on http.Client

  await registerSharedPreferencesServices();

  registerExericeService();

  Dio dio = DioFactory.getDio();
  sl.registerLazySingleton<ApiService>(() => ApiService(dio));

  workoutsAndRoutine();

  // Example: A Settings Cubit - maybe a singleton if settings are global
  // If it depends on something async like UserPreferences, ensure it's ready
  // Option A: Lazy Singleton (waits for UserPreferences if needed)
  // sl.registerLazySingleton<SettingsCubit>(() => SettingsCubit(userPreferences: sl()));

  // Option B: Regular Singleton (if UserPreferences registration guarantees it's ready)
  // sl.registerLazySingleton<SettingsCubit>(() => SettingsCubit(userPreferences: sl()));
}

Future<void> registerSharedPreferencesServices() async {
  final sharedPreferences = SharedPreferencesAsync();
  sl.registerSingleton<SharedPreferencesAsync>(sharedPreferences);
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  sl.registerLazySingleton<SharedPrefHelper>(
    () => SharedPrefHelper(sl(), sl()),
  );
}

void registerExericeService() {
  sl.registerLazySingleton<ExericeService>(() => RapidAPIExerciseDB());
  sl.registerLazySingleton<ExericeRepository>(
    () => ExericeRepository(exericeService: sl()),
  );
  sl.registerFactory<ExericesBloc>(() => ExericesBloc(sl()));
}

/// this method to handle dependency for login, workouts, routines and day
void workoutsAndRoutine() {
  // Login
  sl.registerLazySingleton<LoginRepo>(() => LoginRepo(sl()));
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl()));

  // Register
  sl.registerLazySingleton<RegisterRepo>(() => RegisterRepo(sl()));
  sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl()));
}
