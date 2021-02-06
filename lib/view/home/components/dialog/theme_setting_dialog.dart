import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meditation/data_models/meiso_theme.dart';
import 'package:meditation/generated/l10n.dart';
import 'package:meditation/view/common/ripple_widget.dart';
import 'package:meditation/view/home/home_screen.dart';
import 'package:meditation/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

class ThemeSettingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isSubscribed = context.select<MainViewModel, bool>((viewModel) => viewModel.isSubscribed);

    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 8.0, right: 8.0, bottom: 8.0),
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              SizedBox(
                height: 8.0,
              ),
              Text(S.of(context).selectTheme),
              SizedBox(height: 16.0),
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(
                    meisoThemes.length,
                    (index) => RippleWidget(
                        child: Opacity(
                          opacity: (index == THEME_ID_SILENCE || isSubscribed) ? 1.0 : 0.3,
                          child: GridTile(
                            child: Image.asset(meisoThemes[index].imagePath, fit: BoxFit.fill),
                            footer: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Text(meisoThemes[index].themeName)),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (index == THEME_ID_SILENCE || isSubscribed) {
                            _setTheme(context, index);
                          } else {
                            Fluttertoast.showToast(msg: S.of(context).needSubscribe);
                          }
                          Navigator.pop(context);
                        }),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: RippleWidget(
              child: FaIcon(FontAwesomeIcons.windowClose),
              onTap: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    );
  }

  //TODO
  void _setTheme(BuildContext context, int index) {
    final viewModel = Provider.of<MainViewModel>(context, listen: false);
    viewModel.setTheme(index);
  }
}
