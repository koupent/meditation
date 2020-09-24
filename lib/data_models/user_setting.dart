import 'package:flutter/material.dart';

class UserSettings {
  final bool isSkipIntroScreen;
  final int levelId;
  final int themeId;
  final int timeMinutes;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const UserSettings({
    @required this.isSkipIntroScreen,
    @required this.levelId,
    @required this.themeId,
    @required this.timeMinutes,
  });

  UserSettings copyWith({
    bool isSkipIntroScreen,
    int levelId,
    int themeId,
    int timeMinutes,
  }) {
    if ((isSkipIntroScreen == null || identical(isSkipIntroScreen, this.isSkipIntroScreen)) &&
        (levelId == null || identical(levelId, this.levelId)) &&
        (themeId == null || identical(themeId, this.themeId)) &&
        (timeMinutes == null || identical(timeMinutes, this.timeMinutes))) {
      return this;
    }

    return new UserSettings(
      isSkipIntroScreen: isSkipIntroScreen ?? this.isSkipIntroScreen,
      levelId: levelId ?? this.levelId,
      themeId: themeId ?? this.themeId,
      timeMinutes: timeMinutes ?? this.timeMinutes,
    );
  }

  @override
  String toString() {
    return 'UserSettings{isSkipIntroScreen: $isSkipIntroScreen, levelId: $levelId, themeId: $themeId, timeMinutes: $timeMinutes}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSettings &&
          runtimeType == other.runtimeType &&
          isSkipIntroScreen == other.isSkipIntroScreen &&
          levelId == other.levelId &&
          themeId == other.themeId &&
          timeMinutes == other.timeMinutes);

  @override
  int get hashCode => isSkipIntroScreen.hashCode ^ levelId.hashCode ^ themeId.hashCode ^ timeMinutes.hashCode;

  factory UserSettings.fromMap(Map<String, dynamic> map) {
    return new UserSettings(
      isSkipIntroScreen: map['isSkipIntroScreen'] as bool,
      levelId: map['levelId'] as int,
      themeId: map['themeId'] as int,
      timeMinutes: map['timeMinutes'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'isSkipIntroScreen': this.isSkipIntroScreen,
      'levelId': this.levelId,
      'themeId': this.themeId,
      'timeMinutes': this.timeMinutes,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
