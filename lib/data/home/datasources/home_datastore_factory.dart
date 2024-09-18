import 'home_datastore.dart';
import 'home_local_datastore.dart';
import 'home_remote_datastore.dart';

class HomeDataStoreFactory {
  HomeDataStoreFactory(
      {required HomeLocalDatastore localDatastore,
      required HomeRemoteDataStore remoteDataStore}) {
    _homeLocalDatastore = localDatastore;
    _homeRemoteDataStore = remoteDataStore;
  }

  late HomeLocalDatastore _homeLocalDatastore;
  late HomeRemoteDataStore _homeRemoteDataStore;

  HomeDataStore getAudioList() {
    return _homeLocalDatastore;
  }

  HomeDataStore saveAudio() {
    return _homeLocalDatastore;
  }
}
