import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

AppBar buildWebViewAppBar(
  BuildContext context,
  bool isPortrait, {
  required String author,
  required String source,
  required String url,
}) =>
    AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      elevation: 5.0,
      title: Text(
        'visit item'.tr(),
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
