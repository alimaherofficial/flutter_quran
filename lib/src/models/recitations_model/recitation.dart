// ignore_for_file: public_member_api_docs

import 'package:flutter_quran/src/models/recitations_model/translated_name.dart';

class Recitation {
  Recitation({this.id, this.reciterName, this.style, this.translatedName});

  factory Recitation.fromJson(Map<String, dynamic> json) => Recitation(
        id: json['id'] as num?,
        reciterName: json['reciter_name'] as String?,
        style: json['style'] as String?,
        translatedName: json['translated_name'] == null
            ? null
            : TranslatedName.fromJson(
                json['translated_name'] as Map<String, dynamic>,
              ),
      );
  num? id;
  String? reciterName;
  String? style;
  TranslatedName? translatedName;

  Map<String, dynamic> toJson() => {
        'id': id,
        'reciter_name': reciterName,
        'style': style,
        'translated_name': translatedName?.toJson(),
      };
}
