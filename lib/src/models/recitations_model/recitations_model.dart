// ignore_for_file: public_member_api_docs

import 'package:flutter_quran/src/models/recitations_model/recitation.dart';

class RecitationsModel {
  RecitationsModel({this.recitations});

  factory RecitationsModel.fromJson(Map<String, dynamic> json) {
    return RecitationsModel(
      recitations: (json['recitations'] as List<dynamic>?)
          ?.map((e) => Recitation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  List<Recitation>? recitations;

  Map<String, dynamic> toJson() => {
        'recitations': recitations?.map((e) => e.toJson()).toList(),
      };
}
