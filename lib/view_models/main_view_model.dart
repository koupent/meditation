import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meditation/data_models/meiso_theme.dart';
import 'package:meditation/data_models/user_setting.dart';
import 'package:meditation/models/managers/ad_manager.dart';
import 'package:meditation/models/managers/in_app_purchase_manager.dart';
import 'package:meditation/models/managers/sound_manager.dart';
import 'package:meditation/models/repositories/shared_prefs_repository.dart';
import 'package:meditation/utils/constants.dart';
import 'package:meditation/utils/functions.dart';
import 'package:meditation/view/home/home_screen.dart';

class MainViewModel extends ChangeNotifier {
  final SharedPrefsRepository sharedPrefsRepository;
  final SoundManager soundManager;
  final AdManager adManager;
  final InAppPurchaseManager inAppPurchaseManager;

  UserSettings userSettings;

  RunningStatus runningStatus = RunningStatus.BEFORE_START;

  int remainingTimeSeconds = 0;

  String get remainingTimeString => convertTimeFormat(remainingTimeSeconds);

  //TODO
  int intervalRemainingSeconds = INITIAL_INTERVAL;

  //TODO
  double volume = 0.0;

  MainViewModel({this.sharedPrefsRepository, this.soundManager, this.adManager, this.inAppPurchaseManager});

  Future<void> skipIntro() async {
    await sharedPrefsRepository.skipIntro();
  }

  Future<bool> isSkipIntroScreen() async {
    return await sharedPrefsRepository.isSkipIntroScreen();
  }

  Future<void> getUserSettings() async {
    userSettings = await sharedPrefsRepository.getUserSettings();
    remainingTimeSeconds = userSettings.timeMinutes * 60;
    print(remainingTimeString);
    notifyListeners();
  }

  Future<void> setLevel(int index) async {
    await sharedPrefsRepository.setLevel(index);
    getUserSettings();
  }

  Future<void> setTime(int timeMinutes) async {
    await sharedPrefsRepository.setTime(timeMinutes);
    getUserSettings();
  }

  Future<void> setTheme(int index) async {
    await sharedPrefsRepository.setTheme(index);
    getUserSettings();
  }

  void startMeditation() {
    runningStatus = RunningStatus.ON_START;
    notifyListeners();

    intervalRemainingSeconds = INITIAL_INTERVAL;
    int cnt = 0;

    Timer.periodic(Duration(seconds: 1), (timer) async {
      cnt++;
      intervalRemainingSeconds = INITIAL_INTERVAL - cnt;

      if (intervalRemainingSeconds <= 0) {
        timer.cancel();
        await prepareSounds();
        _startMeditationTimer();
      } else if (runningStatus == RunningStatus.PAUSE) {
        timer.cancel();
        resetMeditation();
      }

      notifyListeners();
    });
  }

  Future<void> prepareSounds() async {
    final levelId = userSettings.levelId;
    final themeId = userSettings.themeId;

    final isNeedBgm = themeId != THEME_ID_SILENCE;
    final bgmPath = isNeedBgm ? meisoThemes[themeId].soundPath : null;
    final bellPath = levels[levelId].bellPath;

    await soundManager.prepareSounds(bellPath, bgmPath, isNeedBgm);
  }

  void resumeMeditation() {}

  void resetMeditation() {}

  void pauseMeditation() {
    runningStatus = RunningStatus.PAUSE;
    notifyListeners();
  }

  void changeVolume(double newVolume) {
    volume = newVolume;
    notifyListeners();
  }

  //TODO 瞑想処理
  void _startMeditationTimer() {
    runningStatus = RunningStatus.INHALE;
    notifyListeners();
  }
}
