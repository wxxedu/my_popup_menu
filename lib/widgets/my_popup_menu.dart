import 'dart:async';
import 'package:flutter/material.dart';
import 'package:measure_size/measure_size.dart';
import 'my_popup_painter.dart';

class MyPopupMenu extends StatelessWidget {
  const MyPopupMenu({
    Key? key,
    required this.child,
    this.color = const Color(0xFFFFFFFF),
    this.borderRadius = 12,
    this.padding,
    this.trianglePointerSize = const Size(20, 10),
    this.elevation = 10,
    this.horizontalOffset = 0,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Size trianglePointerSize;
  final double elevation;
  final double horizontalOffset;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPopupPainter(
        color: color,
        cornerRadius: borderRadius,
        trianglePointerSize: trianglePointerSize,
        elevation: elevation,
        trianglePointerHorizontalOffset: horizontalOffset,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: trianglePointerSize.height),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(12),
          child: Material(
            color: color,
            child: child,
          ),
        ),
      ),
    );
  }
}
