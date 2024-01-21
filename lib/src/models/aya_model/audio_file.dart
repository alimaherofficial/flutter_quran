// ignore_for_file: public_member_api_docs

class AudioFile {
  AudioFile({this.verseKey, this.url});

  factory AudioFile.fromJson(Map<String, dynamic> json) => AudioFile(
        verseKey: json['verse_key'] as String?,
        url: json['url'] as String?,
      );
  String? verseKey;
  String? url;

  Map<String, dynamic> toJson() => {
        'verse_key': verseKey,
        'url': url,
      };
}
