import 'package:event_planner/view/core/home_view.dart';
import 'package:flutter/cupertino.dart';

/// Global navigation bar for the app using CupertinoTabScaffold.
/// It manages tab-based navigation while preserving navigation stacks for each tab.
class GlobalNavigationBar extends StatefulWidget {
  const GlobalNavigationBar({Key? key}) : super(key: key);

  @override
  _GlobalNavigationBarState createState() => _GlobalNavigationBarState();
}

class _GlobalNavigationBarState extends State<GlobalNavigationBar> {
  final CupertinoTabController _tabController = CupertinoTabController();

  /// Global keys to track navigation stacks for each tab.
  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    5,
    (index) => GlobalKey<NavigatorState>(),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.of(context).brightness;

    final backgroundColor = brightness == Brightness.dark
        ? const Color(0xFF203A43)
        : const Color.fromARGB(255, 47, 48, 78);

    final activeColor = brightness == Brightness.dark
        ? const Color.fromARGB(255, 128, 199, 197)
        : CupertinoColors.white;

    final inactiveColor = brightness == Brightness.dark
        ? CupertinoColors.white
        : CupertinoColors.inactiveGray;

    return CupertinoTabScaffold(
      controller: _tabController,
      tabBar: CupertinoTabBar(
        backgroundColor: backgroundColor,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        iconSize: 28,
        height: 57,
        items: _buildNavBarItems(),
        onTap: _resetTabNavigation,
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          navigatorKey: _navigatorKeys[index],
          builder: (context) => _buildTabView(index),
        );
      },
    );
  }

  Widget _buildTabView(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      /*case 1:
        return const SpotlightView();
      case 2:
        return const CreateView();
      case 3:
        return const WisdomView();*/
      default:
        return const HomeView();
    }
  }

  void _resetTabNavigation(int index) {
    final navigator = _navigatorKeys[index].currentState;
    if (navigator != null) {
      navigator.popUntil((route) => route.isFirst);
    }
  }

  List<BottomNavigationBarItem> _buildNavBarItems() {
    final items = [
      const BottomNavigationBarItem(
        icon: _NavBarIcon(icon: CupertinoIcons.home),
        label: 'Criar',
      ),
      const BottomNavigationBarItem(
          icon: _NavBarIcon(icon: CupertinoIcons.search)),
      const BottomNavigationBarItem(
          icon: _NavBarIcon(icon: CupertinoIcons.heart)),
    ];

    /*if (user is admin) {
      items.add(
        const BottomNavigationBarItem(
          icon: _NavBarIcon(icon: CupertinoIcons.calendar),
          label: 'Calendario',
        ),
      );
    }*/

    return items;
  }
}

class _NavBarIcon extends StatelessWidget {
  final IconData icon;

  const _NavBarIcon({required this.icon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 2),
      child: Icon(icon),
    );
  }
}
