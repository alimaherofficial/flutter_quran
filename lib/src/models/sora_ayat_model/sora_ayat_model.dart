// ignore_for_file: public_member_api_docs

import 'package:flutter_quran/src/models/sora_ayat_model/audio_file.dart';
import 'package:flutter_quran/src/models/sora_ayat_model/pagination.dart';

class SoraAyatModel {
  SoraAyatModel({this.audioFiles, this.pagination});

  factory SoraAyatModel.fromJson(Map<String, dynamic> json) => SoraAyatModel(
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
