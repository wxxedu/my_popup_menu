import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:my_popup_menu/my_popup_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const PlatformApp(
      title: 'Flutter Demo',
      home: ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: MyPopupIconButton(
          isSelected: true,
          menuContent: const MyPopupMenu(
            size: Size(100, 100),
            child: Text("Hello World!"),
          ),
          selectedIcon: Icon(
            PlatformIcons(context).addCircled,
          ),
          notSelectedIcon: Icon(
            PlatformIcons(context).add,
          ),
        ),
      ),
      body: Center(
        child: CustomPaint(
          size: const Size(100, 200),
          painter: MyPopupPainter(
            color: const Color(0xFFFFFFFF),
            trianglePointerSize: const Size(20, 10),
            cornerRadius: 10,
            elevation: 10,
          ),
        ),
      ),
    );
  }
}
