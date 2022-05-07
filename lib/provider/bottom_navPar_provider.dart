import 'package:flutter/cupertino.dart';

class BottomNavParProvider extends ChangeNotifier {
  int bottomNavBarIndex = 0;

  void changeBottomNavBarIndex(int currentIndex) {
    bottomNavBarIndex = currentIndex;
    notifyListeners();
  }
}
