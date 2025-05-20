import 'package:flutter/material.dart';
import 'package:race_tracker_app/screen/dashboard/dashboard_view.dart';

import 'package:race_tracker_app/screen/home/home_view.dart';
import 'package:race_tracker_app/theme/r_color.dart';

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // attribute
  late int _navigationIndex;
  List<Widget> page = [const HomeView(), const DashboardView()];

  @override
  void initState() {
    _navigationIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        shadowColor: Colors.transparent,
        surfaceTintColor: null,
        backgroundColor: RColor.white,
        selectedIndex: _navigationIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _navigationIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            selectedIcon: Icon(Icons.home_filled, color: RColor.primary),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_rounded),
            selectedIcon: Icon(Icons.bar_chart_rounded, color: RColor.primary),
            label: '',
          ),
        ],
      ),
      body: page[_navigationIndex],
    );
  }
}
