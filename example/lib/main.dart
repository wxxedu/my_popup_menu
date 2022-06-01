import 'dart:async';

import 'package:flutter/material.dart';
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
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({Key? key}) : super(key: key);

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  final StreamController<Size> controller = StreamController<Size>.broadcast();
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Row(
          children: [
            Expanded(child: Container()),
            MyPopupIconButton(
              isSelected: true,
              menuContent: SizedBox(
                width: 200,
                height: 400,
              ),
              icon: Icon(
                PlatformIcons(context).book,
              ),
              notSelectedIcon: Icon(
                PlatformIcons(context).book,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
