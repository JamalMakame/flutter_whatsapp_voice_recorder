import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/service_locator.dart';
import '../../../../data/home/models/audio_model.dart';
import '../../../../domain/feature/home/services/home_service.dart';
import '../../../../domain/feature/home/services/sound_service.dart';

/// This class is responsible for all the business logic related to the Home Screen
class HomeViewModel extends BaseViewModel {
  List<Audio> audioList = [];
  bool isRecording = false;

  late Audio? _currentPlayingAudio = null;
  late Audio? _currentRecordingAudio = null;
  final HomeService _homeService = locator();
  final SoundService _soundService = locator();

  @override
  void dispose() {
    _soundService.dispose();
    super.dispose();
  }

  void permissionCheckAndInitRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
    } else {
      _soundService.init();
    }

    _soundService.initSoundService();

    refreshAudioList();
  }

  void startRecording() {
    if (_soundService.isAudioPlaying() && _currentPlayingAudio != null) {
      stopAudio(_currentPlayingAudio!);
    }
    String fileName = DateTime.now().millisecondsSinceEpoch.toString() + ".aac";
    _currentRecordingAudio = Audio(filePath: fileName, isPlaying: false);

    _soundService.startRecording(fileName);
    isRecording = true;
    notifyListeners();
  }

  void stopRecording() {
    _soundService.stopRecording();
    isRecording = false;
    notifyListeners();
    saveAudio();
  }

  void cancelRecording() {
    if (_currentRecordingAudio != null) {
      _soundService.cancelRecording(_currentRecordingAudio!.filePath);
    }
    _currentRecordingAudio = null;
    isRecording = false;
    notifyListeners();
  }

  void saveAudio() async {
    if (_currentRecordingAudio != null) {
      var failureOrBool =
          await _homeService.saveAudio(audio: _currentRecordingAudio!);
      failureOrBool.fold(
        (failure) => print("Error in Save Audio"),
        (didSave) {
          if (didSave) {
            refreshAudioList();
          }
        },
      );
    }
  }

  void refreshAudioList() async {
    var failureOrList = await _homeService.getAudioList();
    failureOrList.fold(
      (failure) => print("Error in Get List"),
      (audioList) {
        this.audioList = audioList;
        notifyListeners();
      },
    );
  }

  void playAudio(Audio audio) {
    // change status of currently playing track if any track is already playing
    if (_currentPlayingAudio != null) {
      _currentPlayingAudio!.isPlaying = false;

      updateCurrentPlaying();
    }

    _currentPlayingAudio = audio;
    _currentPlayingAudio!.isPlaying = true;

    updateCurrentPlaying();

    _soundService.playAudio(
      fileName: audio.filePath,
      onPlaybackComplete: () {
        if (_currentPlayingAudio != null) {
          _currentPlayingAudio!.isPlaying = false;
          updateCurrentPlaying();
          notifyListeners();
          _currentPlayingAudio = null;
        }
      },
    );
    notifyListeners();
  }

  void updateCurrentPlaying() {
    audioList[audioList.indexWhere(
            (element) => element.hashCode == _currentPlayingAudio.hashCode)] =
        _currentPlayingAudio!;
  }

  void stopAudio(Audio audio) {
    _soundService.stopAudioPlayback();

    _currentPlayingAudio!.isPlaying = false;

    audioList[audioList.indexWhere(
            (element) => element.hashCode == _currentPlayingAudio.hashCode)] =
        _currentPlayingAudio!;

    _currentPlayingAudio = null;

    notifyListeners();
  }
}
