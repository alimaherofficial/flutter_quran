// ignore_for_file: public_member_api_docs

class TranslatedName {
  TranslatedName({this.name, this.languageName});

  factory TranslatedName.fromJson(Map<String, dynamic> json) {
    return TranslatedName(
      name: json['name'] as String?,
      languageName: json['language_name'] as String?,
    );
  }
  String? name;
  String? languageName;

  Map<String, dynamic> toJson() => {
        'name': name,
        'language_name': languageName,
      };
}
