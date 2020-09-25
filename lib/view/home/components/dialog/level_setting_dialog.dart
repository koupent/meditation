import 'package:flutter/material.dart';
import 'package:meditation/generated/l10n.dart';
import 'package:meditation/view/home/home_screen.dart';
import 'package:meditation/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

class LevelSettingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 8.0),
        Text(S.of(context).selectLevel),
        SizedBox(height: 8.0),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: levels.length,
          itemBuilder: (context, int index) => ListTile(
            title: Center(child: Text(levels[index].levelName)),
            subtitle: Center(child: Text(levels[index].explanation)),
            onTap: () {
              _setLevel(context, index);
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }

  //TODO
  void _setLevel(BuildContext context, int index) {
    final viewModel = Provider.of<MainViewModel>(context,listen: false);
    viewModel.setLevel(index);
  }
}
