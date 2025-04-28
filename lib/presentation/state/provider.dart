import 'package:flutter/material.dart';

class StateManager extends ChangeNotifier {
  int currentCarouselIndex = 0;
  int get getCurrentCarouselIndex => currentCarouselIndex;

  void updateCarouselIndex(int index) {
    currentCarouselIndex = index;
    notifyListeners();
  }
}
