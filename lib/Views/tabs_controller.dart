import 'package:flutter/foundation.dart';

/// A simple global controller to coordinate the currently selected bottom tab.
///
/// `BottomTabs` listens to `TabsController.instance.index` and updates its
/// visible tab. Any widget (including `MakeFullscreen`) can set the index to
/// switch the root tab without pushing routes.
class TabsController {
  TabsController._();

  static final TabsController instance = TabsController._();

  final ValueNotifier<int> index = ValueNotifier<int>(0);
  // Shared appBar title exposed for pages embedded in a parent scaffold.
  final ValueNotifier<String> title = ValueNotifier<String>('Tech 120 App');

  void setIndex(int i) => index.value = i;
  void setTitle(String t) => title.value = t;
}
