import 'package:flutter/material.dart';
import 'package:reader/models/ChapterContent.dart';
import 'package:reader/presentations/screens/ReadingScreen.dart';
import 'package:reader/presentations/wrappers/ReadingThemeProvider.dart';
import 'package:reader/repositories/settings/ThemeRepository.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadingPopUpMenu extends StatefulWidget {
  final ReadingScreenState parentState;

  ReadingPopUpMenu(this.parentState);

  @override
  State<StatefulWidget> createState() => _ReadingPopUpMenuState();
}

class _ReadingPopUpMenuState extends State<ReadingPopUpMenu> {
  ChapterContent get chapterContent => widget.parentState.currentContent;

  ValueNotifier<int> currentFontSizeIndex;

  static const fontSizeOptions = <String>[
    "字号 小",
    "字号 中",
    "字号 大",
    "字号 加大",
    "字号 超大",
  ];

  static const fontSizes = <double>[
    8.0,
    14.0,
    24.0,
    32.0,
    48.0,
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _initFontSize();
  }

  void _initFontSize() {
    final theme = ReadingThemeProvider.of(context);
    var initialIndex = fontSizes.indexOf(theme.fontSize);

    if (initialIndex == -1) {
      initialIndex = 1;
    }

    currentFontSizeIndex = ValueNotifier<int>(initialIndex);

    currentFontSizeIndex.addListener(() async {
      final fontSize = fontSizes[currentFontSizeIndex.value];
      await ThemeRepository.saveFontSize(fontSize);

      setState(() {
        ReadingThemeProvider.reloadTheme(context);
      });

      _dismissPopUp();
    });
  }

  void _dismissPopUp() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) => PopUpMenuContainer(
      child:
      GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
        PopUpMenuButton(
          text: "章节目录",
          onTap: _onBackToChapterList,
        ),
        PopUpMenuButton(
          text: "夜晚模式",
          onTap: _onToggleNightMode,
        ),
        PopUpSlider(
          options: fontSizeOptions,
          selected: currentFontSizeIndex,
        ),
        PopUpMenuButton(
            text: "浏览器中打开",
          enabled: chapterContent != null,
          onTap: _onOpenInExternalBrowser,
        ),
          ]
      )
  );

  void _onBackToChapterList() {
    _dismissPopUp();
    Navigator.of(context).pop();
  }

  void _onToggleNightMode() {
    _dismissPopUp();
    ReadingThemeProvider.toggleNightMode(context);
  }

  void _onOpenInExternalBrowser() async {
    _dismissPopUp();

    if (chapterContent == null) {
      return;
    }

    final urlString = chapterContent.url.toString();

    if (await canLaunch(urlString)) {
      await launch(urlString,
          forceSafariVC: false, forceWebView: false);
    }
  }
}

class PopUpMenuContainer extends StatelessWidget {
  final Duration insetAnimationDuration;
  final Curve insetAnimationCurve;
  final Widget child;
  final ShapeBorder shape;

  PopUpMenuContainer({
    Key key,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.shape = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0))),
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final edgeInsets = MediaQuery
        .of(context)
        .viewInsets + EdgeInsets.all(150);
    final theme = ReadingThemeProvider.of(context);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(
            width: edgeInsets.horizontal, height: edgeInsets.vertical),
        child: Material(
          elevation: 24.0,
            color: theme.popUpBackgroundColor,
          type: MaterialType.card,
          shape: shape,
          child: DefaultTextStyle(
              style: theme.popUpMenuTextStyle,
              child: IconTheme.merge(
                  data: theme.popUpMenuIconStyle,
                  child: child
              )
          )
        ),
      ),
    );
  }
}

class PopUpMenuButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final GestureTapCallback onTap;

  const PopUpMenuButton({Key key, this.text, this.enabled = true, this.onTap})
      : super(key: key);

  Decoration _renderDecoration(BuildContext context) =>
      BoxDecoration(
          border: Border.all(
              color: ReadingThemeProvider
                  .of(context)
                  .popUpTextColor,
              width: 1
          )
      );

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: enabled ? onTap : null,
    child: Container(
      alignment: Alignment.center,
      decoration: _renderDecoration(context),
      child: Text(text),
    ),
  );
}

class PopUpSlider extends StatelessWidget {
  final List<String> options;
  final ValueNotifier<int> selected;

  const PopUpSlider({Key key, this.options, this.selected})
      : super(key: key);

  Decoration _renderDecoration(BuildContext context) =>
      BoxDecoration(
          border: Border.all(
              color: ReadingThemeProvider
                  .of(context)
                  .popUpTextColor,
              width: 1
          )
      );

  @override
  Widget build(BuildContext context) =>
      Container(
          alignment: Alignment.center,
          decoration: _renderDecoration(context),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: _renderOnIncrease(),
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.add)
                  ),
                ),
                Text(options[selected.value]),
                InkWell(
                  onTap: _renderOnDecrease(),
                  child: Container(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.remove)
                  ),
                ),
              ]

          )

      );

  GestureTapCallback _renderOnIncrease() =>
      selected.value < options.length - 1 ? () {
        selected.value = selected.value + 1;
      }
          : null;

  GestureTapCallback _renderOnDecrease() =>
      selected.value > 0 ? () {
        selected.value = selected.value - 1;
      }
          : null;
}
