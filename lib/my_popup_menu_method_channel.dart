import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'my_popup_menu_platform_interface.dart';

/// An implementation of [MyPopupMenuPlatform] that uses method channels.
class MethodChannelMyPopupMenu extends MyPopupMenuPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_popup_menu');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
