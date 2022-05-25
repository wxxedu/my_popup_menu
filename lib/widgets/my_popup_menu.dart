import 'package:flutter/widgets.dart';
import 'my_popup_painter.dart';

class MyPopupMenu extends StatelessWidget {
  const MyPopupMenu({
    Key? key,
    required this.child,
    required this.size,
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
  final Size size;
  final Size trianglePointerSize;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          CustomPaint(
            painter: MyPopupPainter(
                color: color,
                cornerRadius: borderRadius,
                trianglePointerSize: trianglePointerSize,
                elevation: elevation),
            size: size,
          ),
          Padding(
            padding:
                EdgeInsetsDirectional.only(top: trianglePointerSize.height),
            child: Padding(
              padding: padding ?? const EdgeInsets.all(10),
              child: Expanded(
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
