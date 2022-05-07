import 'package:flutter/material.dart';
import 'package:news/view/HomeView/components.dart';
import 'package:news/view/HomeView/tabs/business_tab.dart';
import 'package:news/view/HomeView/tabs/entertainment_tab.dart';
import 'package:news/view/HomeView/tabs/health_tab.dart';
import 'package:news/view/HomeView/tabs/sports_tab.dart';
import 'package:news/view/HomeView/tabs/tech_tab.dart';
import 'package:news/view/HomeView/tabs/top_headlines_tab.dart';
import 'package:provider/provider.dart';

import '../../provider/tap_bar_provider.dart';

class HomeView extends StatelessWidget {
  static const id = 'HomeView';

  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return DefaultTabController(
      length: 6,
      initialIndex:
          context.select<TapBarProvider, int>((value) => value.tapBarIndex),
      child: Scaffold(
        appBar: buildHomeViewAppBar(
          context,
          isPortrait,
        ),
        body: const TabBarView(
          children: [
            TopHeadlinesTabView(),
            BusinessTabView(),
            TechTabView(),
            SportsTabView(),
            HealthTabView(),
            EntertainmentTabView(),
          ],
        ),
      ),
    );
  }
}
