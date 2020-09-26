import 'package:flutter/material.dart';
import 'package:meditation/generated/l10n.dart';
import 'package:meditation/utils/constants.dart';
import 'package:meditation/view/styles.dart';
import 'package:meditation/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

class StatusDisplayPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final runningStatus = context.select<MainViewModel, RunningStatus>((viewModel) => viewModel.runningStatus);

    return Column(
      children: <Widget>[
        SizedBox(
          height: 16.0,
        ),
        SizedBox(
          height: 50.0,
          child: Text(
            _upperSmallText(context, runningStatus),
            style: statusUpperTextStyle,
          ),
        ),
        Selector<MainViewModel, int>(
          selector: (context, viewModel) => viewModel.intervalRemainingSeconds,
          builder: (context, intervalRemainingSeconds, child) {
            return Text(
              _lowerLargeText(context, runningStatus, intervalRemainingSeconds),
              style: statusLowerTextStyle,
            );
          },
        ),
      ],
    );
  }

  String _upperSmallText(BuildContext context, RunningStatus runningStatus) {
    var displayText = "";

    switch (runningStatus) {
      case RunningStatus.BEFORE_START:
        displayText = "";
        break;
      case RunningStatus.ON_START:
        displayText = "";
        break;
      case RunningStatus.INHALE:
        displayText = S.of(context).inhale;
        break;
      case RunningStatus.HOLD:
        displayText = S.of(context).hold;
        break;
      case RunningStatus.EXHALE:
        displayText = S.of(context).exhale;
        break;
      case RunningStatus.PAUSE:
        displayText = S.of(context).pause;
        break;
      case RunningStatus.FINISHED:
        displayText = S.of(context).finished;
        break;
    }
    return displayText;
  }

  String _lowerLargeText(BuildContext context, RunningStatus runningStatus, int intervalRemainingSeconds) {
    var displayText = "";

    if (runningStatus == RunningStatus.BEFORE_START) {
      displayText = "";
    } else if (runningStatus == RunningStatus.FINISHED) {
      displayText = S.of(context).finished;
    } else {
      displayText = intervalRemainingSeconds.toString();
    }

    return displayText;
  }
}
