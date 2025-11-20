import 'package:flutter/material.dart';
import 'package:tech_120_app/Views/Manual/home_page_view.dart';
import 'package:tech_120_app/Views/Manual/Testing/chat_view.dart';
import 'package:tech_120_app/Views/Generated/S-Student%20Profile/Student_profile.dart';
import 'package:tech_120_app/Views/tabs_controller.dart';
import 'package:tech_120_app/Views/make_fullscreen.dart';

class BottomTabs extends StatefulWidget {
  const BottomTabs({super.key});

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _currentIndex = 0;
  final List<String> _defaultTitles = ['Home', 'Chat', 'Profile'];

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  // Notifiers to indicate whether each inner navigator can pop. Used to
  // display a back arrow in the root AppBar that pops the inner navigator.
  final List<ValueNotifier<bool>> _canPopNotifiers = [
    ValueNotifier<bool>(false),
    ValueNotifier<bool>(false),
    ValueNotifier<bool>(false),
  ];

  @override
  void initState() {
    super.initState();
    TabsController.instance.index.addListener(_onControllerIndexChanged);
    // initialize shared title to the default for the starting tab
    TabsController.instance.setTitle(_defaultTitles[_currentIndex]);
    // initialize canPop notifiers (they will update as navigators push/pop)
    for (var i = 0; i < _navigatorKeys.length; i++) {
      _canPopNotifiers[i].value =
          _navigatorKeys[i].currentState?.canPop() ?? false;
    }
  }

  @override
  void dispose() {
    TabsController.instance.index.removeListener(_onControllerIndexChanged);
    for (final n in _canPopNotifiers) {
      n.dispose();
    }
    super.dispose();
  }

  void _onTap(int index) {
    if (_currentIndex == index) {
      // If tapping current tab, pop to first route
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
    // keep the global controller in sync so other widgets can change tabs
    TabsController.instance.setIndex(index);
    // update shared appBar title to the default for this tab
    TabsController.instance.setTitle(_defaultTitles[index]);
  }

  Future<bool> _onWillPop() async {
    final isFirstRouteInCurrentTab = !await _navigatorKeys[_currentIndex]
        .currentState!
        .maybePop();
    if (isFirstRouteInCurrentTab) {
      if (_currentIndex != 0) {
        setState(() {
          _currentIndex = 0;
        });
        TabsController.instance.setIndex(0);
        return false;
      }
      return true; // allow app to be popped
    }
    return false;
  }

  void _onControllerIndexChanged() {
    final i = TabsController.instance.index.value;
    if (i != _currentIndex) {
      setState(() {
        _currentIndex = i;
      });
      // when index changes externally, update the shared title to default
      TabsController.instance.setTitle(_defaultTitles[_currentIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    // PopScope is preferred, but to avoid SDK mismatch we keep behavior and
    // silence the deprecation locally. TODO: Replace with `PopScope` once
    // the minimum SDK >= the version that provides it.
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: ValueListenableBuilder<String>(
        valueListenable: TabsController.instance.title,
        builder: (context, appBarTitle, _) {
          final leadingNotifier = _canPopNotifiers[_currentIndex];
          return ValueListenableBuilder<bool>(
            valueListenable: leadingNotifier,
            builder: (context, canPop, __) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(appBarTitle),
                  leading: canPop
                      ? IconButton(
                          icon: const BackButtonIcon(),
                          onPressed: () {
                            _navigatorKeys[_currentIndex].currentState?.pop();
                          },
                        )
                      : null,
                ),
                body: IndexedStack(
                  index: _currentIndex,
                  children: [
                    _buildNavigator(
                      0,
                      (context) => const MakeFullscreen(
                        title: 'Home',
                        child: HomeContent(),
                      ),
                    ),
                    _buildNavigator(
                      1,
                      (context) => const MakeFullscreen(
                        title: 'Chat',
                        child: Placeholder(),
                      ),
                    ),
                    _buildNavigator(
                      2,
                      (context) => MakeFullscreen(
                        title: 'Profile',
                        child: ProfilePage(),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Due 11-24',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.chat),
                      label: 'Chat',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: _currentIndex,
                  selectedItemColor: Colors.blue,
                  onTap: _onTap,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildNavigator(int index, WidgetBuilder builder) {
    return Navigator(
      key: _navigatorKeys[index],
      observers: [_TabNavigatorObserver(_canPopNotifiers[index])],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class _TabNavigatorObserver extends NavigatorObserver {
  _TabNavigatorObserver(this._canPop);

  final ValueNotifier<bool> _canPop;

  void _update() {
    _canPop.value = navigator?.canPop() ?? false;
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _update();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _update();
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    _update();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _update();
  }
}
