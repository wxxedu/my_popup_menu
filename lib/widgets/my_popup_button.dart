import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../helpers/global_key_helpers.dart';
import '../helpers/my_relative_position.dart';
import 'my_popup_menu.dart';

/// A [BlocBuilder] that displays a [PopupMenuButton]
///
/// [isSelected] is used to determine if the [PopupMenuButton] will perform switching action or show the menu. When [isSelected] is false, the [PopupMenuButton] will perform switching action. When [isSelected] is true, the [PopupMenuButton] will show the menu.
///
/// [menuContent] is a [MyPopupMenu] widget that will be displayed when the [PopupMenuButton] is pressed and the [isSelected] is true.
///
/// [icon] is the icon that will be displayed when [isSelected] is true.
///
/// [notSelectedIcon] is the icon that will be displayed when [isSelected] is false.
///
/// [color] is the color of the Icon when [isSelected] is true.
///
/// [notSelectedColor] is the color of the Icon when [isSelected] is false.
///
/// [padding] is the padding of the [PopupMenuButton].
///
///
/// [trianglePointerSize] is the size of the triangle pointer section of the popup menu.
///
/// [elevation] is the elevation of the popup menu.
///
/// [onPressed] is the callback that will be called when the [PopupMenuButton] is pressed and when it is not in the [isSelected] state.
class MyPopupIconButton extends StatefulWidget {
  const MyPopupIconButton({
    Key? key,
    required this.isSelected,
    required this.icon,
    this.menuContent,
    this.onPressed,
    this.notSelectedIcon,
    this.color,
    this.notSelectedColor,
    this.padding = const EdgeInsets.all(0),
    this.disabledColor,
    this.popupOffset = const Offset(0, 0),
    this.animationDuration = const Duration(milliseconds: 150),
    this.minEdgeDistance = 10,
  }) : super(key: key);
  final MyPopupMenu? menuContent;
  final bool isSelected;
  final Offset popupOffset;
  final void Function()? onPressed;
  final Widget icon;
  final Widget? notSelectedIcon;
  final Color? color;
  final Color? notSelectedColor;
  final Color? disabledColor;
  final EdgeInsets? padding;
  final Duration animationDuration;
  final double minEdgeDistance;

  @override
  State<MyPopupIconButton> createState() => _MyPopupIconButtonState();
}

class _MyPopupIconButtonState extends State<MyPopupIconButton>
    with TickerProviderStateMixin {
  final GlobalKey myKey = GlobalKey();
  late final AnimationController _controller;
  late final Animation<double> _animation;
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    )..addListener(
        () {
          setState(() {});
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformIconButton(
      key: myKey,
      onPressed: () => _onPressed(context),
      icon: widget.isSelected
          ? widget.icon
          : widget.notSelectedIcon ?? widget.icon,
      color: widget.isSelected ? widget.color : widget.notSelectedColor,
      disabledColor: widget.disabledColor,
      padding: widget.padding,
    );
  }

  void _onPressed(BuildContext context) {
    if (widget.isSelected && widget.menuContent != null) {
      _showMenu();
    } else {
      widget.onPressed?.call();
    }
  }

  void _showMenu() {
    overlayEntry = OverlayEntry(
      builder: (context) {
        final childPosition = myKey.getChildPosition(
            offset: widget.popupOffset,
            relativePosition: MyRelativePosition.bottomMiddle)!;
        final double screenWidth = MediaQuery.of(context).size.width;
        late final double trianglePointerHorizontalOffset;
        if (childPosition.dx < widget.menuContent!.initialSize.width / 2) {
          trianglePointerHorizontalOffset =
              widget.menuContent!.initialSize.width / 2 +
                  widget.minEdgeDistance -
                  childPosition.dx;
        } else if (screenWidth <
            childPosition.dx + widget.menuContent!.initialSize.width / 2) {
          trianglePointerHorizontalOffset = screenWidth -
              childPosition.dx -
              widget.menuContent!.initialSize.width / 2 -
              widget.minEdgeDistance;
        } else {
          trianglePointerHorizontalOffset = 0;
        }
        return Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _hideMenu,
            ),
            Positioned(
              top: childPosition.dy,
              left: childPosition.dx -
                  widget.menuContent!.initialSize.width / 2 +
                  trianglePointerHorizontalOffset,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, wdg) {
                  return FadeTransition(
                    opacity: _animation,
                    child: ScaleTransition(
                      alignment: Alignment.topCenter,
                      scale: _animation,
                      child: wdg,
                    ),
                  );
                },
                child: widget.menuContent!.buildWithHorizontalOffset(
                  context,
                  -trianglePointerHorizontalOffset,
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context)!.insert(overlayEntry!);
    _controller.forward().orCancel;
  }

  void _hideMenu() async {
    if (overlayEntry != null) {
      await _controller.reverse().orCancel;
      overlayEntry!.remove();
    }
  }

  @override
  void didUpdateWidget(MyPopupIconButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget.animationDuration;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
