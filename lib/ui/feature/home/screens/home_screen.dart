import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voice Recorder"),
      ),
      body: Stack(
        children: [Image.asset("assets/images/whatsapp_background.png")],
      ),
    );
  }
}
