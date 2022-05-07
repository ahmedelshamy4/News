import 'package:flutter/cupertino.dart';

class CarouselSliderProvider extends ChangeNotifier {
  int carouselSliderIndex = 0;

  void changeCarouselSliderIndex(int currentIndex) {
    carouselSliderIndex = currentIndex;
    notifyListeners();
  }
}
