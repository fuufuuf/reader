import 'package:flutter/material.dart';
import 'package:reader/presentations/screens/ReadingScreen.dart';
import 'package:reader/presentations/wrappers/ReadingThemeProvider.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadingPopUpMenu extends StatefulWidget {
  final ReadingScreenState _parentState;

  ReadingPopUpMenu(this._parentState);

  @override
  State<StatefulWidget> createState() => _ReadingPopUpMenuState(_parentState);
}

class _ReadingPopUpMenuState extends State<ReadingPopUpMenu> {
  final ReadingScreenState _parentState;

  _ReadingPopUpMenuState(this._parentState);

  @override
  Widget build(BuildContext context) => PopUpMenuContainer(
          child: GridView.count(crossAxisCount: 2, children: <Widget>[
        PopUpMenuButton(
          text: "章节目录",
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
        PopUpMenuButton(
          text: "夜晚模式",
          onTap: () {
            final theme = ReadingThemeProvider.of(context);

            ReadingThemeProvider.switchTheme(context, !theme.isNightMode);
            Navigator.of(context).pop();
          },
        ),
        PopUpMenuButton(
          text: "字号",
        ),
        PopUpMenuButton(
            text: "浏览器中打开",
            onTap: () async {
              Navigator.of(context).pop();

              if (_parentState.currentContent == null) {
                return;
              }

              final urlString = _parentState.currentContent.url.toString();

              if (await canLaunch(urlString)) {
                await launch(urlString,
                    forceSafariVC: false, forceWebView: false);
              }
            }),
      ]));
}

class PopUpMenuContainer extends StatelessWidget {
  final Duration insetAnimationDuration;
  final Curve insetAnimationCurve;
  final Widget child;
  final ShapeBorder shape;
  final Color backgroundColor;
  final TextStyle textStyle;

  PopUpMenuContainer({
    Key key,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.backgroundColor = const Color.fromARGB(80, 0, 0, 0),
    this.shape = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0))),
    this.textStyle = const TextStyle(
      color: Colors.white,
    ),
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var edgeInsets = MediaQuery.of(context).viewInsets + EdgeInsets.all(100);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(
            width: edgeInsets.horizontal, height: edgeInsets.vertical),
        child: Material(
          elevation: 24.0,
          color: backgroundColor,
          type: MaterialType.card,
          shape: shape,
          child: DefaultTextStyle(style: textStyle, child: child),
        ),
      ),
    );
  }
}

//final theme = ReadingThemeProvider.of(context);
//ReadingThemeProvider.switchTheme(context, !theme.isNightMode);

class PopUpMenuButton extends StatelessWidget {
  final String text;

  final GestureTapCallback onTap;

  const PopUpMenuButton({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.white, width: 1)),
          child: Text(text),
        ),
      );
}
