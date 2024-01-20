/// [QuranData] is a class that contains the mapping of the Quran
/// It contains the surah number, ayah number ... etc
/// of the Quran
class QuranData {

  /// [quranMap] is a map that contains the mapping of the Quran
  /// 
  /// It based on Quran
  /// 
  /// key: is separated by a (:) 
  /// 
  /// the first part is the surah number
  /// 
  /// the second part is the ayah number
  /// 
  /// value: is the object of the ayah
  Map<String, dynamic> quranMap = {};

  /// [pageMap] is a map that contains the mapping of the pages
  ///
  /// key: is the page number
  ///
  /// value: is a list of objects of surah number, start ayah number
  ///  and end ayah number
  ///
  ///  example: ```dart
  /// {"surah": 1, "start": 1, "end": 7},}
  /// ```
  Map<String, dynamic> pageMap = {};

  /// [juzMap] is a map that contains the mapping of the juz
  ///
  /// key: is the juz number
  ///
  /// value: is a map of keys and values
  ///
  /// values of the sub-map: [id, surahs, verses]
  ///
  /// example:
  ///```dart
  /// '1': {
  ///     'id': 1,
  ///     'surahs': [1, 2, 3, 4, 5, 6, 7, 8, 9],
  ///     'verses': {
  ///       '1': {'start': 1, 'end': 7},
  ///       '2': {'start': 1, 'end': 141},
  ///       '3': {'start': 1, 'end': 92},
  ///       '4': {'start': 24, 'end': 147},
  ///       '5': {'start': 82, 'end': 176},
  ///       '6': {'start': 111, 'end': 165},
  ///       '7': {'start': 1, 'end': 87},
  ///       '8': {'start': 41, 'end': 75},
  ///       '9': {'start': 93, 'end': 129},
  ///     },
  ///   },```
  Map<String, dynamic> juzMap = {};

  /// [sajdaMap] is a map that contains the mapping of the sajda
  ///
  /// key: is the surah number
  ///
  /// value: is a verse number
  Map<String, dynamic> sajdaMap = {};

  /// [surahMap] is a map that contains the mapping of the surah
  ///
  /// It based on Surah
  ///
  /// key: is the surah number
  ///
  /// value: is a map of keys and values
  ///
  /// values of the sub-map: [id, name, aya, place, arabic]
  Map<String, dynamic> surahMap = {};
}
