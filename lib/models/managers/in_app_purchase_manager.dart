import 'package:flutter/services.dart';
import 'package:meditation/utils/constants.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class InAppPurchaseManager {
  Offerings offerings;

  bool isDeleteAd = false;
  bool isSubscribed = false;

  //初期化
  Future<void> init() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup("YrLxeeHBiXVtEYHgsqfBzjyRXGrdIkrA");
    offerings = await Purchases.getOfferings();
    print("offerings: $offerings");
  }

  Future<void> getPurchaserInfo() async {
    try {
      final purchaseInfo = await Purchases.getPurchaserInfo();
      updatePurchases(purchaseInfo);
    } on PlatformException catch (e) {
      print(PurchasesErrorHelper.getErrorCode(e).toString());
    }
  }

  //TODO
  Future<void> makePurchase(PurchaseMode purchaseMode) async {
    Package package;
    switch (purchaseMode) {
      case PurchaseMode.DONATE:
        package = offerings.all["donation"].getPackage("donation");
        break;
      case PurchaseMode.DELETE_AD:
        package = offerings.all["delete_ad"].lifetime;
        break;
      case PurchaseMode.SUBSCRIPTION:
        package = offerings.all["monthly_subscription"].monthly;
        break;
    }
    try {
      final purchaseInfo = await Purchases.purchasePackage(package);
      if (purchaseMode != PurchaseMode.DONATE) updatePurchases(purchaseInfo);
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        print("User Cancelled");
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        print("Purchases not allowed on this device.");
      } else if (errorCode == PurchasesErrorCode.purchaseInvalidError) {
        print("Purchases invalid, check payment source.");
      } else {
        print("Unknown Error.");
      }
    }
  }

  void updatePurchases(PurchaserInfo purchaseInfo) {
    final entitlements = purchaseInfo.entitlements.all;

    if (entitlements.isEmpty) {
      isDeleteAd = false;
      isSubscribed = false;
      return;
    }

    if (!entitlements.containsKey("delete_ad")) {
      isDeleteAd = false;
    } else if (entitlements["delete_ad"].isActive) {
      isDeleteAd = true;
    } else {
      isDeleteAd = false;
    }

    if (!entitlements.containsKey("monthly_subscription")) {
      isSubscribed = false;
    } else if (entitlements["monthly_subscription"].isActive) {
      isSubscribed = true;
    } else {
      isSubscribed = false;
    }
  }
}
