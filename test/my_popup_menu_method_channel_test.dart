import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_popup_menu/my_popup_menu_method_channel.dart';

void main() {
  MethodChannelMyPopupMenu platform = MethodChannelMyPopupMenu();
  const MethodChannel channel = MethodChannel('my_popup_menu');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
