import 'package:flutter/material.dart';
import 'package:news/provider/bottom_navPar_provider.dart';
import 'package:news/view/LayoutView/components.dart';
import 'package:provider/provider.dart';

import '../HomeView/home_view.dart';
import '../SavedView/saved_view.dart';
import '../SearchView/search_view.dart';
import '../SettingView/setting_view.dart';

class LayoutView extends StatelessWidget {
  static const String id = 'LayoutView';

  final List<Widget> _layoutScreen = [
    const HomeView(),
    const SearchView(),
    const SavedView(),
    const SettingView(),
  ];

  LayoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layoutScreen[context.select<BottomNavParProvider, int>(
        (value) => value.bottomNavBarIndex,
      )],
      bottomNavigationBar: BuildBottomNavigationBar(
        selectedIndex: context.select<BottomNavParProvider, int>(
            (value) => value.bottomNavBarIndex),
        onClick: (int? currentIndex) {
          context
              .read<BottomNavParProvider>()
              .changeBottomNavBarIndex(currentIndex!);
        },
      ),
    );
  }
}
