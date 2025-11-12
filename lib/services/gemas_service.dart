import 'package:flutter/foundation.dart';

class GemasService with ChangeNotifier {
  int _totalGemas = 0;

  int get totalGemas => _totalGemas;

  void agregarGemas(int gemas) {
    _totalGemas += gemas;
    notifyListeners();
  }

  void restarGemas(int gemas) {
    if (_totalGemas >= gemas) {
      _totalGemas -= gemas;
      notifyListeners();
    }
  }

  void reiniciarGemas() {
    _totalGemas = 0;
    notifyListeners();
  }
}