import '../models/audio_model.dart';
import 'home_datastore.dart';

// Remote datasource only for demonstration purpose.
// Not used in this example.
class HomeRemoteDataStore extends HomeDataStore {
  @override
  Future<List<Audio>> getAudioList() async {
    return []; // not used as remote is not needed
  }

  @override
  Future<bool> saveAudio({required Audio audio}) async {
    return false; // not used as remote is not needed
  }
}
