import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/errors/exceptions.dart';
import '../../../utlis/app_constants.dart';
import '../models/audio_model.dart';
import 'home_datastore.dart';

class HomeLocalDatastore extends HomeDataStore {
  HomeLocalDatastore({required SharedPreferences pref}) {
    _sharedPreferences = pref;
  }

  late SharedPreferences _sharedPreferences;

  @override
  Future<List<Audio>> getAudioList() async {
    try {
      String? audioList = _sharedPreferences.getString(kPrefAudioList);
      List<Audio> a = audioFromJson(audioList!);
      //return audioFromJson(audioList);
      return a;
        } catch (e) {
      throw LocalDbException();
    }
  }

  @override
  Future<bool> saveAudio({required Audio audio}) async {
    try {
      String? audioStringList = _sharedPreferences.getString(kPrefAudioList);
      List<Audio> audios = audioFromJson(audioStringList!);
      audios.add(audio);
      audioStringList = audioToJson(audios);
    
      _sharedPreferences.setString(kPrefAudioList, audioStringList);

      return true;
    } catch (e) {
      throw LocalDbException();
    }
  }
}
