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

  Future<Map<String, dynamic>> enviarEjercicioAlBackend({
    required String userId,
    required String ejercicioId,
    required String respuesta,
    required bool esCorrecto,
    required bool usoGuia,
  }) async {
    try {
      // SIMULACIÓN: Reemplaza esto con tu llamada real al API
      await Future.delayed(const Duration(milliseconds: 500));
      
      // El backend devuelve estos datos
      final gemasGanadas = esCorrecto ? (usoGuia ? 180 : 190) : 0;
      final puntosGanados = esCorrecto ? (usoGuia ? 180 : 190) : 0;
      final nuevoTotalGemas = _totalGemas + gemasGanadas;

      final Map<String, dynamic> backendResponse = {
        'esCorrecto': esCorrecto,
        'gemasGanadas': gemasGanadas,
        'puntosGanados': puntosGanados,
        'totalGemas': nuevoTotalGemas,
      };

      if (esCorrecto) {
        _totalGemas = nuevoTotalGemas;
        notifyListeners();
      }

      return backendResponse;
    } catch (e) {
      return {
        'esCorrecto': false,
        'gemasGanadas': 0,
        'puntosGanados': 0,
        'error': e.toString(),
      };
    }
  }
}