import 'package:flutter/material.dart';
import 'package:timnew_reader/app/reading/ChapterContentRequest.dart';
import 'package:timnew_reader/app/reading/PopUp.dart';
import 'package:timnew_reader/presentations/wrappers/ReadingThemeProvider.dart';
import 'package:timnew_reader/repositories/settings/ThemeRepository.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadingPopUpMenu extends StatefulWidget {
  final ChapterContentRequest request;
  final VoidCallback navigateUp;
  final VoidCallback navigateDown;

  ReadingPopUpMenu({this.request, this.navigateUp, this.navigateDown});

  @override
  State<StatefulWidget> createState() => _ReadingPopUpMenuState();
}

class _ReadingPopUpMenuState extends State<ReadingPopUpMenu> {
  ValueNotifier<double> currentFontSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _initFontSize();
  }

  void _initFontSize() {
    final theme = ReadingThemeProvider.of(context);
    currentFontSize = ValueNotifier<double>(theme.fontSize);

    currentFontSize.addListener(() async {
      await ThemeRepository.saveFontSize(currentFontSize.value);

      setState(() {
        ReadingThemeProvider.reloadTheme(context);
      });

      _dismissPopUp();
    });
  }

  void _dismissPopUp() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) => PopUpContainer(
          child: GridView.count(physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, children: <Widget>[
        PopUpButton(
          text: "章节目录",
          onTap: _onBackToChapterList,
        ),
        PopUpButton(
          text: "夜晚模式",
          onTap: _onToggleNightMode,
        ),
        PopUpPicker<double>.fromValue(
          options: const <String>[
            "字号 小",
            "字号 中",
            "字号 大",
            "字号 加大",
            "字号 超大",
          ],
          values: const <double>[
            8.0,
            14.0,
            24.0,
            32.0,
            48.0,
          ],
          selectedValue: currentFontSize,
          defaultIndex: 1,
        ),
        PopUpButton(
          text: "浏览器中打开",
          enabled: widget.request.hasData,
          onTap: _onOpenInExternalBrowser,
        ),
        PopUpButton(
          text: "前一章节",
          enabled: widget.request.currentData?.hasPrevious ?? false,
          onTap: _gotoPreviousChapter,
        ),
        PopUpButton(
          text: "后一章节",
          enabled: widget.request.currentData?.hasNext ?? false,
          onTap: _gotoNextChapter,
        ),
      ]));

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

    final chapterContent = widget.request.currentData;

    if (chapterContent == null) {
      return;
    }

    final urlString = chapterContent.url.toString();

    if (await canLaunch(urlString)) {
      await launch(urlString, forceSafariVC: false, forceWebView: false);
    }
  }

  void _gotoPreviousChapter() {
    _dismissPopUp();

    widget.navigateUp();
  }

  void _gotoNextChapter() {
    _dismissPopUp();

    widget.navigateDown();
  }
}
