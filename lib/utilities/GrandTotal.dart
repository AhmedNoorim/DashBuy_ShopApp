import 'package:flutter/foundation.dart';

class GrandTotal extends ChangeNotifier {
  static double _total = 0;

  void updateTotal(double newTotal) {
    _total = newTotal;
    notifyListeners();
  }

  double getTotal() {
    return _total;
  }
}
