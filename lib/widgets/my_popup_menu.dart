import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'my_popup_painter.dart';

class MyPopupMenu extends StatelessWidget {
  const MyPopupMenu({
    Key? key,
    required this.child,
    required this.initialSize,
    required this.sizeController,
    this.color = const Color(0xFFFFFFFF),
    this.borderRadius = 12,
    this.padding,
    this.trianglePointerSize = const Size(20, 10),
    this.elevation = 10,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Size initialSize;
  final StreamController<Size> sizeController;
  final Size trianglePointerSize;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Size>(
        stream: sizeController.stream,
        builder: (context, snapshot) {
          return Container(
            width: snapshot.data?.width ?? initialSize.width,
            height: snapshot.data?.height ?? initialSize.height,
            padding: EdgeInsets.zero,
            child: Stack(
              children: [
                CustomPaint(
                  painter: MyPopupPainter(
                      color: color,
                      cornerRadius: borderRadius,
                      trianglePointerSize: trianglePointerSize,
                      elevation: elevation),
                  size: snapshot.data ?? initialSize,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      top: trianglePointerSize.height),
                  child: Padding(
                    padding: padding ?? const EdgeInsets.all(12),
                    child: Material(
                      color: color,
                      child: child,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
