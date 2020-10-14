import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/features/ChapterList/ChapterListScreen.dart';
import 'package:timnew_reader/features/Theme/AppTheme.dart';
import 'package:timnew_reader/features/Theme/ThemeManager.dart';
import 'package:timnew_reader/widgets/DefaultTextIconColor.dart';

import 'ChapterContentRequest.dart';

class ReadingControlPanel extends StatelessWidget {
  final ChapterContentRequest request;

  ReadingControlPanel({this.request});

  static Future show({BuildContext context, ChapterContentRequest request}) {
    final appTheme = context.read<AppTheme>();
    return showModalBottomSheet(
      context: context,
      backgroundColor: appTheme.readingThemeData.popUpBackgroundColor,
      builder: (context) => ReadingControlPanel(request: request),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    final appTheme = context.watch<AppTheme>();
    return DefaultTextIconColor(
      color: appTheme.readingThemeData.popUpTextColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("閱讀面板"),
            ),
            Wrap(
              children: [
                PanelSpacer(),
                PanelButton(
                  icon: Icons.open_in_browser,
                  text: "瀏覽器中打開",
                  onTap: dismissThen(context, () => request.openCurrentChapterInExternalBrowser()),
                ),
                PanelButton(
                  icon: Icons.refresh,
                  text: "重新加載",
                  onTap: dismissThen(context, () => request.reload()),
                ),
                PanelSpacer(),
                PanelSelect(),
                PanelSelect(),
                PanelButton(
                  icon: Icons.menu,
                  text: "章節目錄",
                  onTap: dismissThen(
                    context,
                    () => Navigator.popUntil(context, ModalRoute.withName(ChapterListScreen.routeName)),
                  ),
                ),
                PanelToggleButton(
                  onIcon: Icons.bedtime_outlined,
                  onText: "熄燈",
                  offIcon: Icons.wb_sunny_outlined,
                  offText: "開燈",
                  value: appTheme.brightness == Brightness.light,
                  onTap: dismissThen(context, () => themeManager.invertBrightness()),
                ),
                PanelButton(
                  icon: Icons.arrow_back,
                  text: "上一章節",
                  onTap: dismissThen(context, () => request.loadPreviousChapter()),
                ),
                PanelButton(
                  icon: Icons.arrow_forward,
                  text: "下一章節",
                  onTap: dismissThen(context, () => request.loadNextChapter()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  VoidCallback dismissThen(BuildContext context, void Function() nextAction) => () {
        Navigator.pop(context);
        nextAction();
      };
}

class PanelWidgetContainer extends StatelessWidget {
  final int widthFactor;

  final Widget child;

  const PanelWidgetContainer({
    Key key,
    this.widthFactor: 1,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1 / 4 * widthFactor,
      child: AspectRatio(
        aspectRatio: widthFactor.toDouble(),
        child: child,
      ),
    );
  }
}

class PanelSpacer extends StatelessWidget {
  final int widthFactor;

  const PanelSpacer({Key key, this.widthFactor: 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PanelWidgetContainer(widthFactor: widthFactor);
  }
}

class PanelButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const PanelButton({Key key, this.icon, this.text, this.onTap})
      : assert(icon != null),
        assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => PanelWidgetContainer(
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Icon(icon),
              ),
              Text(text),
            ],
          ),
          onTap: onTap,
        ),
      );
}

class PanelToggleButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool value;
  final IconData onIcon;
  final String onText;
  final IconData offIcon;
  final String offText;

  const PanelToggleButton({
    Key key,
    this.onIcon,
    this.onText,
    this.offIcon,
    this.offText,
    this.value,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => PanelButton(
        text: value ? onText : offText,
        onTap: onTap,
        icon: value ? onIcon : offIcon,
      );
}

class PanelSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) => PanelWidgetContainer(
        widthFactor: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(icon: Icon(Icons.remove_circle_outline), onPressed: () {}),
            Text("測試"),
            IconButton(icon: Icon(Icons.add_circle_outline), onPressed: () {}),
          ],
        ),
      );
}
