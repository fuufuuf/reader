import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:timnew_reader/features/App/common.dart';

class IndexedTrackingScrollController extends TrackingScrollController {
  final GlobalKey sliverListKey = GlobalKey();

  IndexedTrackingScrollController({
    bool keepScrollOffset = true,
    String debugLabel,
  }) : super(keepScrollOffset: keepScrollOffset, debugLabel: debugLabel);

  Future moveToTop({Duration duration, Curve curve}) async {
    position.moveTo(position.minScrollExtent, duration: duration, curve: curve, clamp: true);
  }

  Future moveToBottom({Duration duration, Curve curve}) async =>
      position.moveTo(position.maxScrollExtent, duration: duration, curve: curve, clamp: true);

  Future moveToPreviousScreen({Duration duration, Curve curve}) async =>
      moveByOffset(-position.viewportDimension, duration: duration, curve: curve);

  Future moveToNextScreen({Duration duration, Curve curve}) async =>
      moveByOffset(position.viewportDimension, duration: duration, curve: curve);

  Future moveByOffset(double deltaOffset, {Duration duration, Curve curve}) async {
    final targetOffset = position.pixels + deltaOffset;

    return position.moveTo(targetOffset, duration: duration, curve: curve, clamp: true);
  }

  int findFirstVisibleIndex() => (findFirstVisibleRenderObject().parentData as SliverMultiBoxAdaptorParentData).index;

  RenderObject findFirstVisibleRenderObject() {
    var current = renderSliverList.firstChild;
    while ((current.parentData as SliverMultiBoxAdaptorParentData).layoutOffset + current.size.height < offset) {
      current = renderSliverList.childAfter(current);
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
        SchedulerBinding.instance.addPostFrameCallback((_) => jumpToIndex(index));
        return;
      }

      if (index > lastParentData.index) {
        debugPrint("Go to next screen");
        moveByOffset(lastParentData.layoutOffset);
        SchedulerBinding.instance.addPostFrameCallback((_) => jumpToIndex(index));
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
