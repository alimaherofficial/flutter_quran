// ignore_for_file: public_member_api_docs

class AudioFile {
  AudioFile({
    this.id,
    this.chapterId,
    this.fileSize,
    this.format,
    this.audioUrl,
  });

  factory AudioFile.fromJson(Map<String, dynamic> json) => AudioFile(
        id: json['id'] as int?,
        chapterId: json['chapter_id'] as int?,
        fileSize: json['file_size'] as num?,
        format: json['format'] as String?,
        audioUrl: json['audio_url'] as String?,
      );
  int? id;
  int? chapterId;
  num? fileSize;
  String? format;
  String? audioUrl;

  Map<String, dynamic> toJson() => {
        'id': id,
        'chapter_id': chapterId,
        'file_size': fileSize,
        'format': format,
        'audio_url': audioUrl,
      };
}
