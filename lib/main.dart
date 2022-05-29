import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:news/provider/app_theme_provider.dart';
import 'package:news/utils/helper/app_components.dart';
import 'package:news/utils/helper/cache_helper.dart';
import 'package:news/utils/routes.dart';
import 'package:news/utils/theme.dart';
import 'package:news/view/splash_view.dart';
import 'package:provider/provider.dart';

import 'core/widget_error.dart';
import 'utils/multi_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  errorWidget();
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  await CacheHelper.init();
  await translator.init(
    localeType: LocalizationDefaultType.device,
    language: setLanguage(),
    languagesList: <String>['ar', 'en', 'fr'],
    assetsDirectory: 'assets/langs/',
  );
  return runApp(
    MultiProvider(
      providers: MultiProviders.providers,
      child: LocalizedApp(
        child: const MyApp(),
      ),
    ),
  );
}

String setLanguage() {
  if (CacheHelper.getStringData(key: sharedPrefsLanguageKey) == null) {
    return 'en';
  } else if (CacheHelper.getStringData(key: sharedPrefsLanguageKey) == 'eg') {
    return 'ar';
  } else if (CacheHelper.getStringData(key: sharedPrefsLanguageKey) == 'us') {
    return 'en';
  } else {
    return 'fr';
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: translator.delegates,
      locale: translator.activeLocale,
      supportedLocales: translator.locals(),
      routes: Routs.routs,
      initialRoute: SplashView.id,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: context.select<AppThemeProvider, bool>((value) => value.isDark)
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }
}
