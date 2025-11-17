import 'package:flutter/material.dart';
import 'package:tech_120_app/Views/tabs_controller.dart';

class MakeFullscreen extends StatefulWidget {
  const MakeFullscreen({
    Key? key,
    this.title = 'Peer Mentor Match', // default value
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  State<MakeFullscreen> createState() => _MakeFullscreenState();
}

class _MakeFullscreenState extends State<MakeFullscreen> {
  String? _previousTitle;
  bool _titleSet = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final hasAncestorScaffold = Scaffold.maybeOf(context) != null;
    if (hasAncestorScaffold && !_titleSet) {
      // Save previous title and set the new one for the parent Scaffold's appBar
      _previousTitle = TabsController.instance.title.value;
      // Delay setting the title until after this build frame to avoid
      // "setState() or markNeedsBuild() called during build" errors when
      // listeners rebuild ancestor widgets while the framework is still
      // building the current widget tree.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        TabsController.instance.setTitle(widget.title);
      });
      _titleSet = true;
    }
  }

  @override
  void dispose() {
    if (_titleSet) {
      // Restore previous title when this page is disposed/popped. Use a
      // post-frame callback to avoid modifying widgets during an ongoing
      // build.
      final prev = _previousTitle ?? '';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        TabsController.instance.setTitle(prev);
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If this widget is already inside a Scaffold (for example the
    // `BottomTabs` root provides a Scaffold with appBar/bottomNavigationBar),
    // avoid adding another appBar/bottomNavigationBar. This prevents the
    // duplicate top/bottom bars when pushing pages that use `MakeFullscreen`
    // inside a tab's navigator.
    final hasAncestorScaffold = Scaffold.maybeOf(context) != null;

    final content = SingleChildScrollView(
      child: Center(
        child: widget.child,
      ), // Centers the generated content because it does not perfectly fill the screen
    );

    if (hasAncestorScaffold) {
      // Return just the body so the parent scaffold's appBar/bottom bar remain
      // the single app chrome.
      return content;
    }

    // If there is no ancestor Scaffold, provide a full-screen scaffold with
    // appBar and bottom navigation.
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: content,
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: TabsController.instance.index,
        builder: (context, currentIndex, _) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: currentIndex,
            selectedItemColor: Colors.blue,
            onTap: (int index) {
              // Switch the global tab index instead of pushing routes so each
              // tab preserves its own navigator stack.
              TabsController.instance.setIndex(index);
            },
          );
        },
      ),
    );
  }
}
