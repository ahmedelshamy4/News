import 'package:flutter/material.dart';
import 'package:news/view/HomeView/home_view.dart';
import 'package:news/view/LayoutView/layout_view.dart';
import 'package:news/view/SettingView/AboutView/about_view.dart';
import 'package:news/view/SettingView/setting_view.dart';

import '../view/splash_view.dart';

class Routs {
  static Map<String, WidgetBuilder> routs = {
    SplashView.id: (_) => const SplashView(),
    LayoutView.id: (_) => LayoutView(),
    HomeView.id: (_) => HomeView(),
    SettingView.id: (_) => SettingView(),
    AboutView.id: (_) => AboutView(),
  };
}
