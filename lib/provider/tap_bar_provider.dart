import 'package:flutter/cupertino.dart';

class TapBarProvider extends ChangeNotifier {
  int tapBarIndex = 0;

  void changeTapBarIndex(int currentIndex) {
    tapBarIndex = currentIndex;
    notifyListeners();
  }
}
