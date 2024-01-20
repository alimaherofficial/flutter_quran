// ignore_for_file: inference_failure_on_function_invocation

import 'package:dio/dio.dart';
import 'package:flutter_quran/src/data/quran_data.dart';
import 'package:flutter_quran/src/models/audio_model/audio_model.dart';
import 'package:flutter_quran/src/models/recitations_model/recitations_model.dart';

/// [Quran] is a class that contains all the functions
class Quran {
  /// [getPageBySuraNumber] is a function that returns a page number
  /// based on surah number
  static int getPageBySuraNumber({
    required int suraNumber,
  }) {
    try {
      assert(suraNumber > 0 && suraNumber < 115, 'Sura number is not valid');

      /// Accessing the singleton instance
      final quranData = QuranData.instance;

      return (quranData.suraMap[suraNumber.toString()]
          as Map<String, dynamic>)['page'] as int;
    } catch (e) {
      throw Exception('Sura number is not valid,\n $e');
    }
  }

  /// [getAyaTextBySuraNumberAndAyaNumber] is a function that returns aya text
  /// based on surah number and aya number
  static String getAyaTextBySuraNumberAndAyaNumber({
    required int suraNumber,
    required int ayaNumber,
  }) {
    try {
      assert(suraNumber > 0 && suraNumber < 115, 'Sura number is not valid');
      assert(ayaNumber > 0 && ayaNumber < 287, 'Aya number is not valid');

      /// Accessing the singleton instance
      final quranData = QuranData.instance;
      return (quranData.quranMap['$suraNumber:$ayaNumber']
          as Map<String, dynamic>)['text'] as String;
    } catch (e) {
      throw Exception('Sura number or aya number is not valid,\n $e');
    }
  }

  /// [getAyaAudiosModel] is a function that returns aya audio
  /// based on surah number and aya number and recitation id
  /// audio url from quran.com api
  ///
  static Future<AudioModel> getAyaAudiosModel({
    required int suraNumber,
    required int ayaNumber,
    required int recitationId,
  }) async {
    try {
      assert(suraNumber > 0 && suraNumber < 115, 'Sura number is not valid');
      assert(ayaNumber > 0 && ayaNumber < 287, 'Aya number is not valid');

      /// Accessing the singleton instance
      final data = await Dio().get(
        'https://api.quran.com/api/v4/recitations/$recitationId/by_ayah/$suraNumber:$ayaNumber',
        options: Options(headers: {'Accept': 'application/json'}),
      );
      final audioModel = AudioModel.fromJson(data.data as Map<String, dynamic>);
      if (audioModel.audioFiles == null || audioModel.audioFiles!.isEmpty) {
        throw Exception('No audio files found');
      }
      for (final element in audioModel.audioFiles!) {
        element.url = 'https://audio.qurancdn.com/${element.url}';
      }
      return audioModel;
    } catch (e) {
      throw Exception('Sura number or aya number is not valid,\n $e');
    }
  }

  /// [getRecitations] is a function that returns the recitations
  static Future<RecitationsModel> getRecitations({
    String language = 'en',
  }) async {
    try {
      final data = await Dio().get(
        'https://api.quran.com/api/v4/resources/recitations',
        queryParameters: {'language': language},
        options: Options(headers: {'Accept': 'application/json'}),
      );
      return RecitationsModel.fromJson(data.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Error while fetching recitations,\n $e');
    }
  }
}
