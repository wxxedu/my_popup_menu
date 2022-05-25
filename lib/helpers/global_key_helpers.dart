import 'package:flutter/material.dart';
import 'my_relative_position.dart';

extension GlobalKeyHelpers on GlobalKey {
  /// Returns the [RenderBox] of the [child] widget.
  RenderBox? getRenderBox() {
    if (currentContext != null) {
      return currentContext!.findRenderObject() as RenderBox;
    }

    return null;
  }

  /// Returns the [Offset] of the [child] widget.
  Offset? getChildPosition({
    Offset offset = Offset.zero,
    MyRelativePosition relativePosition = MyRelativePosition.topLeft,
  }) {
    final RenderBox? box = getRenderBox();
    final Size? size = box?.size;
    if (box != null && size != null) {
      final double x = size.width * relativePosition.percentX;
      final double y = size.height * relativePosition.percentY;
      return box.localToGlobal(Offset(x, y)) + offset;
    }
    return null;
  }

  /// Returns the [Size] of the [child] widget.
  ///
  /// If the [child] is not found, returns null.
  Size? getChildSize() {
    final RenderBox? box = getRenderBox();
    if (box != null) return box.size;
    return null;
  }
}
