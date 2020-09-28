import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';

class AdManager {
  BannerAd bannerAd;
  InterstitialAd interstitialAd;

  // 全画面広告のロード有無を格納する変数
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
      ..show(); //キャスケードノーケーション　一つのインスタンスから複数のメソッドを作成
  }

  void initInterstitialAd() {
    interstitialAd = InterstitialAd(
      adUnitId: interstitialAdUnitId,
      listener: _onInterstitialAdEvent,
    );
  }

  //全画面広告が準備できていないときだけ、ロード処理をする
  void loadInterstitialAd() {
    if (!_isInterstitialAdReady) {
      interstitialAd.load();
    }
  }

  // 全画面広告の準備有無を確認し、準備ができていたら広告を表示する
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
        //全画面広告の再描画するための初期化処理
        _isInterstitialAdReady = false;
        interstitialAd.dispose();
        initInterstitialAd();
        break;
      default:
      // do nothing
    }
  }

  //TODO ID変更
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544~4354546703"; //テスト用ID
      return "ca-app-pub-5289290206347181~6581492747"; //リアルID
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
      return "ca-app-pub-5289290206347181/2259104350"; //リアルID
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
      return "ca-app-pub-5289290206347181/9562879302"; //リアルID
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
