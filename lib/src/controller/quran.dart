// ignore_for_file: inference_failure_on_function_invocation

import 'package:dio/dio.dart';
import 'package:flutter_quran/src/data/quran_data.dart';
import 'package:flutter_quran/src/models/aya_model/aya_model.dart';
import 'package:flutter_quran/src/models/recitations_model/recitations_model.dart';
import 'package:flutter_quran/src/models/sora_ayat_model/audio_file.dart';
import 'package:flutter_quran/src/models/sora_ayat_model/sora_ayat_model.dart';
import 'package:flutter_quran/src/models/sora_model/sora_model.dart';
import 'package:flutter_quran/src/models/sour_model/sour_model.dart';

/// [Quran] is a class that contains all the functions
class Quran {
  /// [getPageBySuraNumber] is a function that returns a page number
  /// based on surah number
  static int getPageBySuraNumber({
    required int suraNumber,
  }) {
    try {
      assert(suraNumber > 0 && suraNumber < 115, 'Sura number is not valid');



      return (QuranData.suraMap[suraNumber.toString()]
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

      return (QuranData.quranMap['$suraNumber:$ayaNumber']
          as Map<String, dynamic>)['text'] as String;
    } catch (e) {
      throw Exception('Sura number or aya number is not valid,\n $e');
    }
  }

  /// [getAyaAudios] is a function that returns aya audio
  /// based on surah number and aya number and recitation id
  /// audio url from quran.com api
  ///
  static Future<AyaModel> getAyaAudios({
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
      final audioModel = AyaModel.fromJson(data.data as Map<String, dynamic>);
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

  /// [getSora] is a function that returns the sora that contains the aya link
  static Future<SoraModel> getSora({
    required int soraNumber,
    required int recitationId,
  }) async {
    try {
      assert(soraNumber > 0 && soraNumber < 115, 'Sora number is not valid');
      final data = Dio().get(
        'https://api.quran.com/api/v4/chapter_recitations/$recitationId/$soraNumber',
        options: Options(headers: {'Accept': 'application/json'}),
      );
      return SoraModel.fromJson((await data).data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Sora number is not valid,\n $e');
    }
  }

  /// [getSora] is a function that returns the sora that contains the aya link
  static Future<SourModel> getAllSourAudios({
    required int recitationId,
  }) async {
    try {
      final data = Dio().get(
        'https://api.quran.com/api/v4/chapter_recitations/$recitationId',
        options: Options(headers: {'Accept': 'application/json'}),
      );
      return SourModel.fromJson((await data).data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Sora number is not valid,\n $e');
    }
  }

  /// [getAyahtAudioListForSpecificPart] is a function that returns the list of
  /// ayat for specific part of the quran
  static Future<List<AudioFile>> getAyahtAudioListForSpecificPart({
    required int recitationId,
    required int startSurahNumber,
    required int startAyahNumber,
    required int endSurahNumber,
    required int endAyahNumber,
  }) async {
    try {
      final audioFiles = <AudioFile>[];
      if (startSurahNumber == endSurahNumber) {
        final soraAyatModel = await _getSoraAyatModel(
          recitationId: recitationId,
          surahNumber: startSurahNumber,
        );
        audioFiles.addAll(
          soraAyatModel.audioFiles!.where((element) {
            final ayahNumber = int.parse(element.verseKey!.split(':').last);
            if (ayahNumber < startAyahNumber || ayahNumber > endAyahNumber) {
              return false;
            }
            return true;
          }),
        );
      } else {
        final loopCount = endSurahNumber - startSurahNumber + 1;

        for (var i = 0; i < loopCount; i++) {
          final soraNumber = startSurahNumber + i;
          final soraAyatModel = await _getSoraAyatModel(
            recitationId: recitationId,
            surahNumber: soraNumber,
          );
          if (soraNumber == startSurahNumber) {
            audioFiles.addAll(
              soraAyatModel.audioFiles!.where((element) {
                final ayahNumber = int.parse(element.verseKey!.split(':').last);
                if (ayahNumber < startAyahNumber) {
                  return false;
                }
                return true;
              }),
            );
          } else if (soraNumber == endSurahNumber) {
            audioFiles.addAll(
              soraAyatModel.audioFiles!.where((element) {
                final ayahNumber = int.parse(element.verseKey!.split(':').last);
                if (ayahNumber > endAyahNumber) {
                  return false;
                }
                return true;
              }),
            );
          } else {
            audioFiles.addAll(soraAyatModel.audioFiles!);
          }
        }
      }
      return audioFiles;
    } catch (e) {
      throw Exception('Sora number is not valid,\n $e');
    }
  }

  static Future<SoraAyatModel> _getSoraAyatModel({
    required int recitationId,
    required int surahNumber,
  }) async {
    try {
      final data = Dio().get(
        'https://api.quran.com/api/v4/recitations/$recitationId/by_chapter/$surahNumber',
        options: Options(
          headers: {'Accept': 'application/json'},
        ),
        queryParameters: {
          'per_page': 300,
        },
      );
      final soraAyatModel =
          SoraAyatModel.fromJson((await data).data as Map<String, dynamic>);
      if (soraAyatModel.audioFiles == null ||
          soraAyatModel.audioFiles!.isEmpty) {
        throw Exception('No ayat found');
      }
      for (final element in soraAyatModel.audioFiles!) {
        element.url = 'https://audio.qurancdn.com/${element.url}';
      }
      return soraAyatModel;
    } catch (e) {
      throw Exception('Sora number is not valid,\n $e');
    }
  }
}
