import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

import '../../../../data/home/models/audio_model.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/widget_record_mic.dart';
import '../widgets/widget_timer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget buildList(HomeViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: model.audioList.length,
        itemBuilder: (context, index) {
          Audio audio = model.audioList[index];
          return Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                audio.isPlaying
                    ? model.stopAudio(audio)
                    : model.playAudio(audio);
              },
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        audio.isPlaying
                            ? Icons.stop_circle_outlined
                            : Icons.play_circle,
                        size: 30,
                        color: Colors.teal,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: audio.isPlaying
                            ? Lottie.asset(
                                "assets/lottie/audio_waves_teal.json",
                                width: 100,
                                height: 50,
                                fit: BoxFit.fill,
                              )
                            : Text("Audio ${index + 1}"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.transparent,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.permissionCheckAndInitRecorder(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Voice Recorder"),
        ),
        body: SizedBox(
          height: screenSize.height,
          child: Stack(
            children: [
              SizedBox(
                height: screenSize.height,
                child: Image.asset(
                  "assets/images/whatsapp_background.png",
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: RecordingMicWidget(
                  onVerticalScrollComplete: () {},
                  onHorizontalScrollComplete: () {
                    model.cancelRecording();
                  },
                  onLongPress: () {
                    model.startRecording();
                  },
                  onLongPressCancel: () {
                    model.stopRecording();
                  },
                  onSend: () {
                    model.stopRecording();
                  },
                  onTapCancel: () {
                    model.cancelRecording();
                  },
                ),
              ),
              SizedBox(
                height: screenSize.height -
                    (MediaQuery.of(context).padding.top + kToolbarHeight) -
                    65,
                child: model.audioList.isNotEmpty
                    ? buildList(model)
                    : const SizedBox(),
              ),
              Positioned(
                bottom: 25,
                left: 25,
                child:
                    model.isRecording ? const TimerWidget() : const SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
