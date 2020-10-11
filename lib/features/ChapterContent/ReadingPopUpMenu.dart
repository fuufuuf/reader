import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/features/BookList/BookListScreen.dart';
import 'package:timnew_reader/features/Theme/AppTheme.dart';
import 'package:timnew_reader/features/Theme/ThemeManager.dart';

import 'package:url_launcher/url_launcher.dart';

import 'ChapterContentRequest.dart';
import 'PopUp.dart';

class ReadingPopUpMenu extends StatelessWidget {
  final ChapterContentRequest request;
  final VoidCallback navigateUp;
  final VoidCallback navigateDown;

  ReadingPopUpMenu({this.request, this.navigateUp, this.navigateDown});

  void _dismissPopUp(BuildContext context) => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return PopUpContainer(
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        children: <Widget>[
          PopUpButton(
            text: "章节目录",
            onTap: () => _onBackToChapterList(context),
          ),
          PopUpButton(
            text: "夜晚模式",
            onTap: () => _onToggleNightMode(context),
          ),
          PopUpPicker<double>(
            options: const <String>[
              "標準",
              "1.2x",
              "1.4x",
              "1.6x",
              "1.8x",
              "2.0x",
            ],
            values: const <double>[
              1.0,
              1.2,
              1.4,
              1.6,
              1.8,
              2.0,
            ],
            value: context.watch<AppTheme>().readingThemeData.fontScaleFactor,
            defaultIndex: 0,
            onValueChanged: (newScaleFactor) => _onTextScaleChanged(context, newScaleFactor),
          ),
          PopUpButton(
            text: "浏览器中打开",
            enabled: request.hasData,
            onTap: () => _onOpenInExternalBrowser(context),
          ),
          PopUpButton(
            text: "前一章节",
            enabled: request.currentData?.hasPrevious ?? false,
            onTap: () => _gotoPreviousChapter(context),
          ),
          PopUpButton(
            text: "后一章节",
            enabled: request.currentData?.hasNext ?? false,
            onTap: () => _gotoNextChapter(context),
          ),
        ],
      ),
    );
  }

  void _onBackToChapterList(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(BookListScreen.routeName));
  }

  void _onToggleNightMode(BuildContext context) {
    _dismissPopUp(context);
    context.read<ThemeManager>().invertBrightness();
  }

  _onTextScaleChanged(BuildContext context, double newScaleFactor) {
    _dismissPopUp(context);

    context.read<ThemeManager>().updateTextScale(newScaleFactor);
  }

  void _onOpenInExternalBrowser(BuildContext context) async {
    _dismissPopUp(context);

    final chapterContent = request.currentData;

    if (chapterContent == null) {
      return;
    }

    final urlString = chapterContent.url.toString();

    if (await canLaunch(urlString)) {
      await launch(urlString, forceSafariVC: false, forceWebView: false);
    }
  }

  void _gotoPreviousChapter(BuildContext context) {
    _dismissPopUp(context);

    navigateUp();
  }

  void _gotoNextChapter(BuildContext context) {
    _dismissPopUp(context);

    navigateDown();
  }
}
