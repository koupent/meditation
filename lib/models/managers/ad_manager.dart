import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';

class AdManager {
  BannerAd bannerAd;
  InterstitialAd interstitialAd;

  //TODO この変数の目的を確認
  bool _isInterstitialAdReady = false;

  Future<void> initAdmob() {
    return FirebaseAdMob.instance.initialize(appId: appId);
  }

  void initBannerAd() {
    bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
    );
  }

  void loadBannerAd() {
    bannerAd
      ..load()
      ..show(anchorType: AnchorType.bottom); //キャスケードノーケーション　一つのインスタンスから複数のメソッドを作成
  }

  void initInterstitialAd() {
    interstitialAd = InterstitialAd(
      adUnitId: interstitialAdUnitId,
      listener: _onInterstitialAdEvent,
    );
  }

  void loadInterstitialAd() {
    if (!_isInterstitialAdReady) {
      interstitialAd.load();
    }
  }

  //TODO
  void _onInterstitialAdEvent(MobileAdEvent event) {
    switch (event) {
      case MobileAdEvent.loaded:
        _isInterstitialAdReady = true;
        _showInterstitialAd();
        break;
      case MobileAdEvent.failedToLoad:
        _isInterstitialAdReady = false;
        print('Failed to load an interstitial ad');
        break;
      case MobileAdEvent.closed:
        _isInterstitialAdReady = false;
        interstitialAd.dispose();
        initInterstitialAd();
        // _moveToHome();
        break;
      default:
      // do nothing
    }
  }

  //TODO ID変更
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544~4354546703"; //テスト用ID
      return "ca-app-pub-5289290206347181~6581492747";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544~2594085930"; //テスト用ID
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  //TODO ID変更
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/8865242552"; //テスト用ID
      return "ca-app-pub-5289290206347181/2259104350";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4339318960"; //テスト用ID
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  //TODO ID変更
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/7049598008"; //テスト用ID
      return "ca-app-pub-5289290206347181/9562879302";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/3964253750"; //テスト用ID
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  void dispose() {
    bannerAd.dispose();
    interstitialAd.dispose();
  }

  void _showInterstitialAd() {
    if (_isInterstitialAdReady) {
      interstitialAd.show();
    }
  }
}
