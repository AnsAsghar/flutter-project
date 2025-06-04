import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// Features
import '../../features/plant_identification/data/datasources/plant_local_data_source.dart';
import '../../features/plant_identification/data/datasources/plant_remote_data_source.dart';
import '../../features/plant_identification/data/models/plant_model.dart';
import '../../features/plant_identification/data/repositories/plant_repository_impl.dart';
import '../../features/plant_identification/domain/repositories/plant_repository.dart';
import '../../features/plant_identification/domain/usecases/identify_plant.dart';
import '../../features/plant_identification/domain/usecases/save_plant.dart';
import '../../features/plant_identification/domain/usecases/get_saved_plants.dart';
import '../../features/plant_identification/presentation/bloc/plant_identification_bloc.dart';

import '../../features/onboarding/data/datasources/onboarding_local_data_source.dart';
import '../../features/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../../features/onboarding/domain/repositories/onboarding_repository.dart';
import '../../features/onboarding/domain/usecases/check_onboarding_status.dart';
import '../../features/onboarding/domain/usecases/complete_onboarding.dart';

import 'constants.dart';

final sl = GetIt.instance;

Future<void> init() async {
  try {
    //! Features - Plant Identification
    // Bloc
    sl.registerFactory(
      () => PlantIdentificationBloc(
        identifyPlant: sl(),
        savePlant: sl(),
        getSavedPlants: sl(),
      ),
    );

    // Use cases
    sl.registerLazySingleton(() => IdentifyPlant(sl()));
    sl.registerLazySingleton(() => SavePlant(sl()));
    sl.registerLazySingleton(() => GetSavedPlants(sl()));

    // Repository
    sl.registerLazySingleton<PlantRepository>(
      () => PlantRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
    );

    // Data sources
    sl.registerLazySingleton<PlantRemoteDataSource>(
      () => PlantRemoteDataSourceImpl(client: sl()),
    );
    sl.registerLazySingleton<PlantLocalDataSource>(
      () => PlantLocalDataSourceImpl(plantsBox: sl()),
    );

    //! Features - Onboarding
    // Use cases
    sl.registerLazySingleton(() => CheckOnboardingStatus(sl()));
    sl.registerLazySingleton(() => CompleteOnboarding(sl()));

    // Repository
    sl.registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(localDataSource: sl()),
    );

    // Data sources
    sl.registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImpl(sharedPreferences: sl()),
    );

    //! Core
    sl.registerLazySingleton(() => http.Client());

    //! External
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);

    // Initialize Hive and register adapters
    Hive.registerAdapter(PlantModelAdapter());

    final plantsBox = await Hive.openBox<PlantModel>(
      AppConstants.plantsBoxName,
    );
    sl.registerLazySingleton(() => plantsBox);
  } catch (e) {
    // Re-throw the error to be handled by main.dart
    throw Exception('Failed to initialize dependencies: $e');
  }
}
