import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:measure_size/measure_size.dart';
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
  }) : super(key: key);
  final Widget? menuContent;
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

  @override
  State<MyPopupIconButton> createState() => _MyPopupIconButtonState();
}

class _MyPopupIconButtonState extends State<MyPopupIconButton>
    with TickerProviderStateMixin {
  final GlobalKey myKey = GlobalKey();
  final GlobalKey overlayKey = GlobalKey();
  late final AnimationController _controller;
  late final Animation<double> _animation;

  OverlayEntry? overlayEntry;
  Size size = Size.zero;
  bool offstage = true;
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

    if (widget.menuContent != null) {
      // calculate the size of the popup menu
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) async {
          await _showMenu();
          await _hideMenu();
          offstage = false;
        },
      );
    }
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

  Future<void> _showMenu() async {
    overlayEntry = OverlayEntry(
      builder: (context) {
        final childPosition = myKey.getChildPosition(
            offset: widget.popupOffset,
            relativePosition: MyRelativePosition.bottomMiddle)!;
        final trianglePointerHorizontalOffset = _getHoriOffset(
          childPosition: childPosition,
          size: size,
        );

        return Offstage(
          offstage: offstage,
          child: Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _hideMenu,
              ),
              Positioned(
                top: childPosition.dy,
                left: childPosition.dx -
                    size.width / 2 +
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
                  child: MeasureSize(
                    onChange: _onSizeChanged,
                    child: MyPopupMenu(
                      horizontalOffset: -trianglePointerHorizontalOffset,
                      child: widget.menuContent!,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context)!.insert(overlayEntry!);
    await _controller.forward().orCancel;
  }

  Future<void> _hideMenu() async {
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

  void _onSizeChanged(Size size) {
    setState(() {
      this.size = size;
    });
  }

  double _getHoriOffset({
    required Size size,
    required Offset childPosition,
  }) {
    final windowWidth = MediaQuery.of(context).size.width;
    if (childPosition.dx - (size.width / 2) < 0) {
      return size.width / 2 - childPosition.dx;
    } else if (childPosition.dx + (size.width / 2) > windowWidth) {
      return windowWidth - childPosition.dx - (size.width / 2);
    } else {
      return 0;
    }
  }
}
