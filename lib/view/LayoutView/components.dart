import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../utils/colors.dart';

class BuildBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int?) onClick;

  const BuildBottomNavigationBar(
      {Key? key, required this.selectedIndex, required this.onClick})
      : super(key: key);

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required int index,
    required int selectedIndex,
    required IconData selectedIcon,
    required IconData unselectedIcon,
    required String toolTip,
  }) {
    return BottomNavigationBarItem(
      label: '',
      tooltip: toolTip,
      icon: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: 2.5,
              width: 35,
              color: index == selectedIndex ? appMainColor : appGreyColor,
              margin: const EdgeInsets.only(bottom: 7.0),
            ),
            Icon(
              index == selectedIndex ? selectedIcon : unselectedIcon,
              size: index == selectedIndex ? 27.0 : 23.0,
            ),
          ],
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> items({required int index}) {
    return [
      _buildBottomNavigationBarItem(
        index: index,
        selectedIndex: 0,
        selectedIcon: Icons.home,
        unselectedIcon: Icons.home_outlined,
        toolTip: 'home tooltip'.tr(),
      ),
      _buildBottomNavigationBarItem(
        index: index,
        selectedIndex: 1,
        selectedIcon: Icons.search,
        unselectedIcon: Icons.search_outlined,
        toolTip: 'search tooltip'.tr(),
      ),
      _buildBottomNavigationBarItem(
        index: index,
        selectedIndex: 2,
        selectedIcon: Icons.bookmark,
        unselectedIcon: Icons.bookmark_border_outlined,
        toolTip: 'saved tooltip'.tr(),
      ),
      _buildBottomNavigationBarItem(
        index: index,
        selectedIndex: 3,
        selectedIcon: Icons.settings,
        unselectedIcon: Icons.settings,
        toolTip: 'Setting'.tr(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 1.5,
          width: double.infinity,
          color: appGreyColor,
        ),
        BottomNavigationBar(
            selectedFontSize: 0,
            onTap: onClick,
            currentIndex: selectedIndex,
            items: items(
              index: selectedIndex,
            ))
      ],
    );
  }
}
