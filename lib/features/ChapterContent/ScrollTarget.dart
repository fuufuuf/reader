import 'package:freezed_annotation/freezed_annotation.dart';

part 'ScrollTarget.freezed.dart';

@freezed
abstract class ScrollTarget with _$ScrollTarget {
  factory ScrollTarget.top() = ScrollToTop;

  factory ScrollTarget.bottom() = ScrollToBottm;

  factory ScrollTarget.paragraph(@Default(0) int index) = ScrollToParagraph;
}
