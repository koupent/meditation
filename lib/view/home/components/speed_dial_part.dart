import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meditation/generated/l10n.dart';
import 'package:meditation/utils/constants.dart';
import 'package:meditation/view/styles.dart';
import 'package:meditation/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

class SpeedDialPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final iconTheme = Theme.of(context).iconTheme;
    final runningStatus = context.select<MainViewModel, RunningStatus>((viewModel) => viewModel.runningStatus);

    return runningStatus != RunningStatus.BEFORE_START
        ? Container()
        : SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: iconTheme.color,
            overlayColor: dialogBackgroundColor,
            marginBottom: 60.0,
            children: [
              SpeedDialChild(
                child: FaIcon(FontAwesomeIcons.donate),
                label: S.of(context).donation,
                labelBackgroundColor: speedDialLabelBackgroundColor,
                onTap: () => _donate(context),
              ),
              SpeedDialChild(
                child: FaIcon(FontAwesomeIcons.ad),
                label: S.of(context).deleteAd,
                labelBackgroundColor: speedDialLabelBackgroundColor,
                onTap: () => _deleteAd(context),
              ),
              SpeedDialChild(
                child: FaIcon(FontAwesomeIcons.subscript),
                label: S.of(context).subscription,
                labelBackgroundColor: speedDialLabelBackgroundColor,
                onTap: () => _subscribe(context),
              ),
              SpeedDialChild(
                child: FaIcon(FontAwesomeIcons.undo),
                label: S.of(context).recoverPurchase,
                labelBackgroundColor: speedDialLabelBackgroundColor,
                onTap: () => _recoverPurchase(context),
              ),
            ],
          );
  }

  //寄付
  _donate(BuildContext context) {
    final viewModel = context.read<MainViewModel>();
    viewModel.makePurchase(PurchaseMode.DONATE);
  }

  // 広告削除
  _deleteAd(BuildContext context) {
    final viewModel = context.read<MainViewModel>();
    if (!viewModel.isDeleteAd) {
      viewModel.makePurchase(PurchaseMode.DELETE_AD);
    } else {
      Fluttertoast.showToast(msg: S.of(context).alreadyPurchased);
    }
  }

  // 月額課金
  _subscribe(BuildContext context) {
    final viewModel = context.read<MainViewModel>();
    if (!viewModel.isSubscribed) {
      viewModel.makePurchase(PurchaseMode.SUBSCRIPTION);
    } else {
      Fluttertoast.showToast(msg: S.of(context).alreadyPurchased);
    }
  }

  //TODO
  _recoverPurchase(BuildContext context) {}
}
