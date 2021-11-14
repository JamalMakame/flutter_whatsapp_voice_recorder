import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/home/datasources/home_datastore_factory.dart';
import '../data/home/datasources/home_local_datastore.dart';
import '../data/home/datasources/home_remote_datastore.dart';
import '../data/home/repository/home_repository_impl.dart';
import '../domain/feature/home/repository/home_repository.dart';
import '../domain/feature/home/services/home_service.dart';
import '../domain/feature/home/services/sound_service.dart';

var locator = GetIt.instance;

Future<void> init() async {
  //! core
  locator.registerLazySingleton(() => FlutterSoundRecorder());
  locator.registerLazySingleton(() => FlutterSoundPlayer());

  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  locator.registerLazySingleton<SoundService>(
    () => SoundService(
      recorder: locator(),
      soundPlayer: locator(),
    ),
  );

  //! Here all the classes required for the MVVM clean architecture gets created
  //! when needed and are injected wherever needed.

  //! home
  locator.registerLazySingleton<HomeLocalDatastore>(
    () => HomeLocalDatastore(pref: locator()),
  );
  locator.registerLazySingleton<HomeRemoteDataStore>(
    () => HomeRemoteDataStore(),
  );
  locator.registerLazySingleton<HomeDataStoreFactory>(
    () => HomeDataStoreFactory(
      localDatastore: locator(),
      remoteDataStore: locator(),
    ),
  );
  locator.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      homeDataStoreFactory: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => HomeService(homeRepository: locator()),
  );
}
