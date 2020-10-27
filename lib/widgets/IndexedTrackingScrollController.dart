import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:timnew_reader/features/App/common.dart';

class IndexedTrackingScrollController extends TrackingScrollController {
  final GlobalKey sliverListKey = GlobalKey();

  IndexedTrackingScrollController({
    bool keepScrollOffset = true,
    String debugLabel,
  }) : super(keepScrollOffset: keepScrollOffset, debugLabel: debugLabel);

  bool get isAutoScrolling => _isAutoScrolling;
  bool _isAutoScrolling;

  void _beginAutoScroll() {
    _isAutoScrolling = true;
    debugPrint("Begin auto Scrolling");
    notifyListeners();
  }

  void _endAutoScroll() {
    _isAutoScrolling = false;
    debugPrint("End auto Scrolling");
    notifyListeners();
  }

  bool get isAtTop => position.pixels <= position.minScrollExtent;

  bool get isAtBottom => position.pixels >= position.maxScrollExtent;

  Future moveToTop({Duration duration, Curve curve}) async {
    _beginAutoScroll();

    await position.moveTo(position.minScrollExtent, duration: duration, curve: curve, clamp: true);

    _endAutoScroll();
  }

  Future moveToBottom({Duration duration, Curve curve}) async {
    _beginAutoScroll();

    await position.moveTo(position.maxScrollExtent, duration: duration, curve: curve, clamp: true);

    // This is to make sure the Future is completed after the callback is invoked
    final completer = Completer<void>();

    // As position.maxScrollExtent is an estimated value, which could have changed after the initial jump.
    // This move is to correct the potential over-scroll / under-scroll in post frame callback of next frame, when the layout and view update has been completed.
    WidgetsBinding.instance.scheduleFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          // Correct the potential over-scroll and under-scroll
          await position.moveTo(position.maxScrollExtent, clamp: true);

          _endAutoScroll();
          completer.complete();
        } catch (ex, stackTrace) {
          completer.completeError(ex, stackTrace);
        }
      });
    });

    return completer.future;
  }

  Future moveToPreviousScreen({Duration duration, Curve curve}) async =>
      moveByOffset(-position.viewportDimension, duration: duration, curve: curve);

  Future moveToNextScreen({Duration duration, Curve curve}) async =>
      moveByOffset(position.viewportDimension, duration: duration, curve: curve);

  Future moveByOffset(double deltaOffset, {Duration duration, Curve curve}) async {
    final targetOffset = position.pixels + deltaOffset;

    _beginAutoScroll();
    await position.moveTo(targetOffset, duration: duration, curve: curve, clamp: true);
    _endAutoScroll();
  }

  int findFirstVisibleIndex() => (findFirstVisibleRenderObject()?.parentData as SliverMultiBoxAdaptorParentData)?.index;

  RenderObject findFirstVisibleRenderObject() {
    var current = renderSliverList.firstChild;

    if (current == null) return null;

    while ((current.parentData as SliverMultiBoxAdaptorParentData).layoutOffset + current.size.height < offset) {
      current = renderSliverList.childAfter(current);
      if (current == null) return null;
    }

    return current;
  }

  SliverMultiBoxAdaptorElement get sliverListElement => sliverListKey.currentContext as SliverMultiBoxAdaptorElement;

  RenderSliverList get renderSliverList => sliverListElement.renderObject as RenderSliverList;

  SliverMultiBoxAdaptorParentData get firstParentData =>
      renderSliverList.firstChild.parentData as SliverMultiBoxAdaptorParentData;

  SliverMultiBoxAdaptorParentData get lastParentData =>
      renderSliverList.lastChild.parentData as SliverMultiBoxAdaptorParentData;

  void jumpToIndex(int index) {
    debugPrint("find: $index => [${firstParentData.index}, ${lastParentData.index}]");

    if (!index.isWithIn(firstParentData.index, lastParentData.index)) {
      if (index < firstParentData.index) {
        debugPrint("Go to previous screen");
        moveByOffset(-position.viewportDimension);
        WidgetsBinding.instance.addPostFrameCallback((_) => jumpToIndex(index));
        return;
      }

      if (index > lastParentData.index) {
        debugPrint("Go to next screen");
        moveByOffset(lastParentData.layoutOffset);
        WidgetsBinding.instance.addPostFrameCallback((_) => jumpToIndex(index));
        return;
      }
    }

    final offset = _findParentDataInRange(index).layoutOffset;
    debugPrint("Found offset: $offset");
    jumpTo(offset);
  }

  SliverMultiBoxAdaptorParentData _findParentDataInRange(int index) {
    final forwardOffset = index - firstParentData.index;
    final backwardOffset = lastParentData.index - index;

    if (forwardOffset == 0)
      return renderSliverList.firstChild.parentData as SliverMultiBoxAdaptorParentData;
    else if (backwardOffset == 0)
      return renderSliverList.lastChild.parentData as SliverMultiBoxAdaptorParentData;
    else if (forwardOffset < backwardOffset)
      return _findParentDataForward(index);
    else
      return _findParentDataBackward(index);
  }

  SliverMultiBoxAdaptorParentData _findParentDataForward(int index) {
    var currentRenderObject = renderSliverList.firstChild;
    while ((currentRenderObject.parentData as SliverMultiBoxAdaptorParentData).index < index) {
      currentRenderObject = renderSliverList.childAfter(currentRenderObject);
    }

    final result = currentRenderObject.parentData as SliverMultiBoxAdaptorParentData;
    assert(result.index == index);

    return result;
  }

  SliverMultiBoxAdaptorParentData _findParentDataBackward(int index) {
    var currentRenderObject = renderSliverList.lastChild;
    while ((currentRenderObject.parentData as SliverMultiBoxAdaptorParentData).index > index) {
      currentRenderObject = renderSliverList.childBefore(currentRenderObject);
    }

    final result = currentRenderObject.parentData as SliverMultiBoxAdaptorParentData;
    assert(result.index == index);

    return result;
  }
}
