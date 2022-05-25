import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../helpers/global_key_helpers.dart';
import '../helpers/my_relative_position.dart';
import 'my_popup_menu.dart';

/// A [BlocBuilder] that displays a [PopupMenuButton]
class MyPopupIconButton extends StatefulWidget {
  const MyPopupIconButton({
    Key? key,
    required this.isSelected,
    required this.menuContent,
    this.onPressed,
    this.selectedIcon,
    this.notSelectedIcon,
    this.selectedColor,
    this.notSelectedColor,
    this.padding,
    this.disabledColor,
    this.popupOffset = const Offset(0, 0),
  }) : super(key: key);
  final MyPopupMenu menuContent;
  final bool isSelected;
  final Offset popupOffset;
  final void Function()? onPressed;
  final Widget? selectedIcon;
  final Widget? notSelectedIcon;
  final Color? selectedColor;
  final Color? notSelectedColor;
  final Color? disabledColor;
  final EdgeInsets? padding;

  @override
  State<MyPopupIconButton> createState() => _MyPopupIconButtonState();
}

class _MyPopupIconButtonState extends State<MyPopupIconButton>
    with TickerProviderStateMixin {
  final GlobalKey myKey = GlobalKey();
  late final AnimationController _controller;

  OverlayEntry? overlayEntry;
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _controller.addListener(update);
  }

  void update() {
    setState(() {
      opacity = _controller.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformIconButton(
      key: myKey,
      onPressed: () => _onPressed(context),
      icon: widget.isSelected ? widget.selectedIcon : widget.notSelectedIcon,
      color: widget.isSelected ? widget.selectedColor : widget.notSelectedColor,
      disabledColor: widget.disabledColor,
      padding: widget.padding,
    );
  }

  void _onPressed(BuildContext context) {
    if (widget.isSelected) {
      _showMenu();
    } else {
      if (widget.onPressed != null) widget.onPressed!();
    }
  }

  void _showMenu() {
    overlayEntry = OverlayEntry(
      builder: (context) {
        final childPosition = myKey.getChildPosition(
            offset: widget.popupOffset,
            relativePosition: MyRelativePosition.bottomMiddle)!;
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, wdg) {
            return Opacity(
              opacity: opacity,
              child: wdg,
            );
          },
          child: Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _hideMenu,
              ),
              Positioned(
                top: childPosition.dy,
                left: childPosition.dx - widget.menuContent.size.width / 2,
                child: widget.menuContent.build(context),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context)!.insert(overlayEntry!);
    _controller.forward();
  }

  void _hideMenu() async {
    if (overlayEntry != null) {
      await _controller.reverse().orCancel;
      overlayEntry!.remove();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
