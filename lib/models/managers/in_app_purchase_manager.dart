import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class InAppPurchaseManager {
  Offerings offerings;

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

  void updatePurchases(PurchaserInfo purchaseInfo) {}
}
