
import 'my_popup_menu_platform_interface.dart';

class MyPopupMenu {
  Future<String?> getPlatformVersion() {
    return MyPopupMenuPlatform.instance.getPlatformVersion();
  }
}
