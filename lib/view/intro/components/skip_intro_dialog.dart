import 'package:flutter/material.dart';
import 'package:meditation/generated/l10n.dart';

class SkipIntroDialog extends StatelessWidget {
  final VoidCallback onSkipped;

  SkipIntroDialog({@required this.onSkipped});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 24.0,
          ),
          Center(
            child: Text(
              S.of(context).skipIntroConfirm,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: onSkipped,
                child: Text(S.of(context).yes),
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text(S.of(context).no),
              ),
            ],
          )
        ],
      ),
    );
  }
}
