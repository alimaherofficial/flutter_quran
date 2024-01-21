// ignore_for_file: public_member_api_docs

import 'package:flutter_quran/src/models/sour_model/audio_file.dart';

class SourModel {
  SourModel({this.audioFiles});

  factory SourModel.fromJson(Map<String, dynamic> json) => SourModel(
        audioFiles: (json['audio_files'] as List<dynamic>?)
            ?.map((e) => AudioFile.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  List<AudioFile>? audioFiles;

  Map<String, dynamic> toJson() => {
        'audio_files': audioFiles?.map((e) => e.toJson()).toList(),
      };
}
