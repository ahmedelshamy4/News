import 'package:news/provider/app_theme_provider.dart';
import 'package:news/provider/bottom_navPar_provider.dart';
import 'package:news/provider/carousel_slider_provider.dart';
import 'package:news/provider/tap_bar_provider.dart';
import 'package:news/view_model/article_view_model.dart';
import 'package:news/view_model/database_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MultiProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<AppThemeProvider>(
        create: (context) => AppThemeProvider()),
    ChangeNotifierProvider<BottomNavParProvider>(
        create: (context) => BottomNavParProvider()),
    ChangeNotifierProvider<TapBarProvider>(
        create: (context) => TapBarProvider()),
    ChangeNotifierProvider<ArticleViewModel>(
        create: (context) => ArticleViewModel()),
    ChangeNotifierProvider<CarouselSliderProvider>(
        create: (context) => CarouselSliderProvider()),
    ChangeNotifierProvider<DatabaseViewModel>(
        create: (context) => DatabaseViewModel()),
  ];
}
