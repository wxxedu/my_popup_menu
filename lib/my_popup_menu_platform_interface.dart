import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_popup_menu_method_channel.dart';

abstract class MyPopupMenuPlatform extends PlatformInterface {
  /// Constructs a MyPopupMenuPlatform.
  MyPopupMenuPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyPopupMenuPlatform _instance = MethodChannelMyPopupMenu();

  /// The default instance of [MyPopupMenuPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyPopupMenu].
  static MyPopupMenuPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyPopupMenuPlatform] when
  /// they register themselves.
  static set instance(MyPopupMenuPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
