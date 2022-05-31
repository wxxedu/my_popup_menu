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
    return PlatformApp(
      title: 'Flutter Demo',
      home: ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatelessWidget {
  ExampleHomePage({Key? key}) : super(key: key);
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
              menuContent: MyPopupMenu(
                sizeController: controller,
                initialSize: const Size(200, 300),
                child: TextButton(
                  child: Text("add Size"),
                  onPressed: () {
                    controller.add(Size(200, 800));
                  },
                ),
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
