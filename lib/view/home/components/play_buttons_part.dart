import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meditation/utils/constants.dart';
import 'package:meditation/view/common/ripple_widget.dart';
import 'package:meditation/view/styles.dart';
import 'package:meditation/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

class PlayButtonsPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final runningStatus = context.select<MainViewModel, RunningStatus>((viewModel) => viewModel.runningStatus);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Center(
            child: RippleWidget(
              child: _largePlayIcon(context, runningStatus),
              onTap: () => _onPlayButtonPressed(context, runningStatus),
            ),
          ),
          Positioned(
            left: 8.0,
            bottom: 8.0,
            child: (runningStatus == RunningStatus.PAUSE)
                ? RippleWidget(
                    child: Icon(
                      FontAwesomeIcons.stopCircle,
                      size: smallPlayIconSize,
                    ),
                    onTap: () => _onStopButtonPressed(context),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget _largePlayIcon(BuildContext context, RunningStatus runningStatus) {
    Icon icon;
    if (runningStatus == RunningStatus.BEFORE_START || runningStatus == RunningStatus.PAUSE) {
      icon = Icon(
        FontAwesomeIcons.playCircle,
        size: largePlayIconSize,
      );
    } else if (runningStatus == RunningStatus.FINISHED) {
      icon = Icon(
        FontAwesomeIcons.stopCircle,
        size: largePlayIconSize,
      );
    } else {
      icon = Icon(
        FontAwesomeIcons.pauseCircle,
        size: largePlayIconSize,
      );
    }
    return icon;
  }

  void _onPlayButtonPressed(BuildContext context, RunningStatus runningStatus) {
    final viewModel = context.read<MainViewModel>();
    if (runningStatus == RunningStatus.BEFORE_START) {
      viewModel.startMeditation();
    } else if (runningStatus == RunningStatus.PAUSE) {
      viewModel.resumeMeditation();
    } else if (runningStatus == RunningStatus.FINISHED) {
      viewModel.resetMeditation();
    } else {
      viewModel.pauseMeditation();
    }
  }

  _onStopButtonPressed(BuildContext context) {
    final viewModel = context.read<MainViewModel>();
    viewModel.resetMeditation();
  }
}
