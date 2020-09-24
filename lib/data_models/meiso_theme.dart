import 'package:flutter/material.dart';

const int THEME_ID_SILENCE = 0;
const int THEME_ID_CAVE = 1;
const int THEME_ID_SPRING = 2;
const int THEME_ID_SUMMER = 3;
const int THEME_ID_AUTUMN = 4;
const int THEME_ID_STREAM = 5;
const int THEME_ID_WIND_BELLS = 6;
const int THEME_ID_BONFIRE = 7;

class MeisoTheme {
  final int themeId;
  final String themeName;
  final String imagePath;
  final String soundPath;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const MeisoTheme({
    @required this.themeId,
    @required this.themeName,
    @required this.imagePath,
    @required this.soundPath,
  });

  MeisoTheme copyWith({
    int themeId,
    String themeName,
    String imagePath,
    String soundPath,
  }) {
    if ((themeId == null || identical(themeId, this.themeId)) &&
        (themeName == null || identical(themeName, this.themeName)) &&
        (imagePath == null || identical(imagePath, this.imagePath)) &&
        (soundPath == null || identical(soundPath, this.soundPath))) {
      return this;
    }

    return new MeisoTheme(
      themeId: themeId ?? this.themeId,
      themeName: themeName ?? this.themeName,
      imagePath: imagePath ?? this.imagePath,
      soundPath: soundPath ?? this.soundPath,
    );
  }

  @override
  String toString() {
    return 'MeisoTheme{themeId: $themeId, themeName: $themeName, imagePath: $imagePath, soundPath: $soundPath}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeisoTheme &&
          runtimeType == other.runtimeType &&
          themeId == other.themeId &&
          themeName == other.themeName &&
          imagePath == other.imagePath &&
          soundPath == other.soundPath);

  @override
  int get hashCode => themeId.hashCode ^ themeName.hashCode ^ imagePath.hashCode ^ soundPath.hashCode;

  factory MeisoTheme.fromMap(Map<String, dynamic> map) {
    return new MeisoTheme(
      themeId: map['themeId'] as int,
      themeName: map['themeName'] as String,
      imagePath: map['imagePath'] as String,
      soundPath: map['soundPath'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'themeId': this.themeId,
      'themeName': this.themeName,
      'imagePath': this.imagePath,
      'soundPath': this.soundPath,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
