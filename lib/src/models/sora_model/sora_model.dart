// ignore_for_file: public_member_api_docs

import 'package:flutter_quran/src/models/sora_model/audio_file.dart';

class SoraModel {
  SoraModel({this.audioFile});

  factory SoraModel.fromJson(Map<String, dynamic> json) => SoraModel(
        audioFile: json['audio_file'] == null
            ? null
            : AudioFile.fromJson(json['audio_file'] as Map<String, dynamic>),
      );
  AudioFile? audioFile;

  Map<String, dynamic> toJson() => {
        'audio_file': audioFile?.toJson(),
      };
}
