import 'package:flutter_test/flutter_test.dart';
import 'package:my_popup_menu/my_popup_menu.dart';
import 'package:my_popup_menu/my_popup_menu_platform_interface.dart';
import 'package:my_popup_menu/my_popup_menu_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMyPopupMenuPlatform 
    with MockPlatformInterfaceMixin
    implements MyPopupMenuPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MyPopupMenuPlatform initialPlatform = MyPopupMenuPlatform.instance;

  test('$MethodChannelMyPopupMenu is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMyPopupMenu>());
  });

  test('getPlatformVersion', () async {
    MyPopupMenu myPopupMenuPlugin = MyPopupMenu();
    MockMyPopupMenuPlatform fakePlatform = MockMyPopupMenuPlatform();
    MyPopupMenuPlatform.instance = fakePlatform;
  
    expect(await myPopupMenuPlugin.getPlatformVersion(), '42');
  });
}
