#import "MyPopupMenuPlugin.h"
#if __has_include(<my_popup_menu/my_popup_menu-Swift.h>)
#import <my_popup_menu/my_popup_menu-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "my_popup_menu-Swift.h"
#endif

@implementation MyPopupMenuPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMyPopupMenuPlugin registerWithRegistrar:registrar];
}
@end
