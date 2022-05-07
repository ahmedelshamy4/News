import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:news/app_components.dart';

import '../utils/colors.dart';
import 'LayoutView/layout_view.dart';

class SplashView extends StatefulWidget {
  static const id = 'SplashView';

  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 2), () {
      namedNavigator(context, LayoutView.id);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 205.0,
              width: 200.0,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 5.0),
            GradientText(
              'app name'.tr(),
              gradient: LinearGradient(
                colors: [
                  Colors.orange.shade200,
                  appMainColor,
                ],
              ),
              style: const TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
