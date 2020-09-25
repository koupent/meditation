import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditation/generated/l10n.dart';
import 'package:meditation/view/home/home_screen.dart';
import 'package:meditation/view/styles.dart';
import 'package:meditation/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

class TimeSettingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timeSelectButtons = List.generate(
      meisoTimes.length,
      (index) => FlatButton(
        onPressed: () {
          _setTime(context, meisoTimes[index].timeMinutes);
          Navigator.pop(context);
        },
        child: Text(
          meisoTimes[index].timeDisplayString,
          style: timeSettingDisplayTextStyle,
        ),
      ),
    );

    return Container(
      height: 180.0,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 8.0,
          ),
          Text(S.of(context).selectTime),
          Table(
            children: [
              TableRow(children: [
                timeSelectButtons[0],
                timeSelectButtons[1],
                timeSelectButtons[2],
              ]),
              TableRow(children: [
                timeSelectButtons[3],
                timeSelectButtons[4],
                timeSelectButtons[5],
              ]),
            ],
          ),
        ],
      ),
    );
  }

  //TODO
  void _setTime(BuildContext context, int timeMinutes) {
    final viewModel = Provider.of<MainViewModel>(context,listen: false);
    viewModel.setTime(timeMinutes);

    Fluttertoast.showToast(msg: S.of(context).timeAdjusted);
  }
}
