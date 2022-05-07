import 'package:flutter/cupertino.dart';
import 'package:news/utils/helper/cache_helper.dart';

import '../utils/helper/app_components.dart';

class AppThemeProvider extends ChangeNotifier {
  bool? cacheTheme = CacheHelper.getBooleanData(key: sharedPrefsThemeKey);

  AppThemeProvider() {
    changeAppTheme(currentTheme: cacheTheme);
  }

  bool isDark = true;

  void changeAppTheme({bool? currentTheme, bool switchValue = false}) {
    if (currentTheme != null) {
      isDark = currentTheme;
      notifyListeners();
    } else {
      isDark = switchValue;
      CacheHelper.setBooleanData(key: sharedPrefsThemeKey, value: isDark);
      notifyListeners();
    }
  }
}
