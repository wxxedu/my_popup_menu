import 'package:flutter/material.dart';
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
          buildPopupMenu: (context) => const MyPopupMenu(
            size: Size(200, 200),
            child: Text('Hello World'),
          ),
          selectedIcon: Icon(
            PlatformIcons(context).book,
          ),
          notSelectedIcon: Icon(
            PlatformIcons(context).book,
          ),
        ),
      ),
    );
  }
}
