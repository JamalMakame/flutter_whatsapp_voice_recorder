import 'dart:convert';

List<Audio> audioFromJson(String str) =>
    List<Audio>.from(json.decode(str).map((x) => Audio.fromJson(x)));

String audioToJson(List<Audio> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Audio {
  Audio({
    required this.filePath,
    required this.isPlaying,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        filePath: json["filePath"],
        isPlaying: json["isPlaying"],
      );

  late String filePath;
  late bool isPlaying;

  Map<String, dynamic> toJson() => {
        "filePath": filePath,
        "isPlaying": isPlaying,
      };
}
