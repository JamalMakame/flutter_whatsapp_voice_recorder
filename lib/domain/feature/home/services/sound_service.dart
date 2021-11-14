import 'package:flutter/scheduler.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';

class SoundService {
  late FlutterSoundRecorder _soundRecorderService;
  late FlutterSoundPlayer _soundPlayer;

  SoundService({
    required FlutterSoundRecorder recorder,
    required FlutterSoundPlayer soundPlayer,
  }) {
    _soundRecorderService = recorder;
    _soundPlayer = soundPlayer;
  }

  void init() async {
    _soundRecorderService.openAudioSession();
  }

  void initSoundService() {
    _soundPlayer.openAudioSession();
  }

  void dispose() {
    _soundRecorderService.closeAudioSession();
    _soundPlayer.closeAudioSession();
  }

  void startRecording(String fileName) async {
    _soundRecorderService.startRecorder(toFile: fileName);
  }

  void stopRecording() async {
    _soundRecorderService.stopRecorder();
  }

  void cancelRecording(String fileName) async {
    _soundRecorderService.deleteRecord(fileName: fileName);
  }

  void playAudio({
    required String fileName,
    required VoidCallback onPlaybackComplete,
  }) async {
    await _soundPlayer.startPlayer(
      fromURI: fileName,
      whenFinished: onPlaybackComplete,
    );
  }

  void stopAudioPlayback() {
    _soundPlayer.stopPlayer();
  }

  bool isAudioPlaying() {
    return _soundPlayer.isPlaying;
  }
}
