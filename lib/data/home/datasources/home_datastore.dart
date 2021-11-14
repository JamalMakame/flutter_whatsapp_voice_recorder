import '../models/audio_model.dart';

abstract class HomeDataStore {
  Future<bool> saveAudio({required Audio audio});

  Future<List<Audio>> getAudioList();
}
