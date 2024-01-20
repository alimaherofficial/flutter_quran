// ignore_for_file: public_member_api_docs

import 'package:flutter_quran/src/models/audio_model/audio_file.dart';
import 'package:flutter_quran/src/models/audio_model/pagination.dart';

class AudioModel {
  AudioModel({this.audioFiles, this.pagination});

  factory AudioModel.fromJson(Map<String, dynamic> json) => AudioModel(
        audioFiles: (json['audio_files'] as List<dynamic>?)
            ?.map((e) => AudioFile.fromJson(e as Map<String, dynamic>))
            .toList(),
        pagination: json['pagination'] == null
            ? null
            : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      );
  List<AudioFile>? audioFiles;
  Pagination? pagination;

  Map<String, dynamic> toJson() => {
        'audio_files': audioFiles?.map((e) => e.toJson()).toList(),
        'pagination': pagination?.toJson(),
      };
}
