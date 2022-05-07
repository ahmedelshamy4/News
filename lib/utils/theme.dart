import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData buildAppCustomTheme({
  required Color scaffoldBackgroundColor,
  required Color appBarColor,
  required Color tabBarLabelColor,
  required Color bottomNavBarColor,
}) {
  return ThemeData(
    primaryColor: appMainColor,
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    fontFamily: 'Tajawal',
    appBarTheme: AppBarTheme(
      backgroundColor: appBarColor,
      centerTitle: true,
      elevation: 5.0,
      iconTheme: const IconThemeData(color: appMainColor, size: 26.0),
      titleTextStyle: const TextStyle(
        color: appMainColor,
        fontSize: 22.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Tajawal',
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: tabBarLabelColor,
      labelStyle: const TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Tajawal',
      ),
      unselectedLabelColor: appGreyColor,
      unselectedLabelStyle: const TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Tajawal',
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: bottomNavBarColor,
      selectedItemColor: appMainColor,
      unselectedItemColor: appGreyColor,
      elevation: 50.0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
  );
}

final ThemeData lightTheme = buildAppCustomTheme(
  scaffoldBackgroundColor: secondLightColor,
  appBarColor: mainLightColor,
  tabBarLabelColor: blackColor,
  bottomNavBarColor: mainLightColor,
);

///APP DARK THEME
final ThemeData darkTheme = buildAppCustomTheme(
    scaffoldBackgroundColor: secondDarkColor,
    appBarColor: mainDarkColor,
    tabBarLabelColor: whiteColor,
    bottomNavBarColor: mainDarkColor);
