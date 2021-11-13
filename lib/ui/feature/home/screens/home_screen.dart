import 'package:flutter/material.dart';
import 'package:flutter_whatsapp_voice_recorder/ui/feature/home/widgets/widget_record_mic.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
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
                onVerticalScrollComplete: () {
                  print("Vertical Swpie Complete");
                },
                onHorizontalScrollComplete: () {
                  print("Horizontal Swpie Complete");
                },
                onLongPress: () {
                  print("Long Press Received");
                },
                onLongPressCancel: () {
                  print("Long Press Cancel Received");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
