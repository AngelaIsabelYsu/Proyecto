import 'package:flutter/material.dart';
import '../../widgets/appbar.dart' as appbar_file;
import 'podio.dart';
import 'consejo_ia.dart';

class EjerciciosCompletosScreen extends StatefulWidget {
  const EjerciciosCompletosScreen({super.key});

  @override
  State<EjerciciosCompletosScreen> createState() => _EjerciciosCompletosScreenState();
}

class _EjerciciosCompletosScreenState extends State<EjerciciosCompletosScreen> {
  final int puntajeActual = 20;
  final int puntajeMaximo = 20;

  final List<Map<String, dynamic>> _ejercicios = [
    {'numero': 1, 'titulo': 'Pregunta', 'completado': true},
    {'numero': 2, 'titulo': 'Ejercicio', 'completado': true},
    {'numero': 3, 'titulo': 'Ejercicio', 'completado': true},
    {'numero': 4, 'titulo': 'Ejercicio', 'completado': true},
  ];

  void _verPuntuacion() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PodioScreen(
          puntajeUsuario: puntajeActual,
        ),
      ),
    );
  }

  void _verConsejoIA() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ConsejoIAScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: appbar_file.AppBarComponents.buildAppBar(
        context, 
        'SEM 1:Derivadas y sus Aplicaciones'
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // PUNTAJE Y MASCOTA
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // PUNTAJE
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF42A5F5), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(15),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Puntaje actual:',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$puntajeActual/$puntajeMaximo',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 30),
                
                // LLAMA
                Image.asset(
                  'assets/images/llama.png',
                  width: 140,
                  height: 140,
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.emoji_emotions,
                        size: 80,
                        color: Colors.orange,
                      ),
                    );
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // LISTA DE EJERCICIOS
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _ejercicios.length,
              itemBuilder: (context, index) {
                final ejercicio = _ejercicios[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEB3B),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(15),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${ejercicio['titulo']} Nº ${ejercicio['numero']}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Completo',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFF4DD0E1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            
            const SizedBox(height: 20),
            
            // BOTONES EN FILA
            Row(
              children: [
                // BOTÓN VER PUNTUACIÓN
                Expanded(
                  child: ElevatedButton(
                    onPressed: _verPuntuacion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDC143C),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 3,
                    ),
                    child: const Text(
                      'Ver puntuación',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // BOTÓN CONSEJO DE IA
                Expanded(
                  child: ElevatedButton(
                    onPressed: _verConsejoIA,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDC143C),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 3,
                    ),
                    child: const Text(
                      'Consejo de IA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
      
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 1),
    );
  }
}