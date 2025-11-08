import 'package:flutter/material.dart';
import '../../widgets/appbar.dart';

class ConsejoIAScreen extends StatelessWidget {
  const ConsejoIAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarComponents.buildSimpleAppBar(context, 'Consejo de IA'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Sección superior con imagen y texto EN FILA - SIN CONTAINER
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Texto - CON MÁRGEN IZQUIERDO AUMENTADO
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 16, left: 30),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 20), // SOLO el párrafo bajado
                        child: Text(
                          'Analizaremos tus puntos fuertes y áreas de mejora, con recomendaciones concretas para tu desarrollo.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Imagen del personaje - SIN CAMBIOS
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: SizedBox(
                      width: 140,
                      height: 140,
                      child: Image.asset(
                        'assets/images/llamaia.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // CARDS SIN CAMBIOS
            _buildAdviceCard(
              icon: Icons.check_circle,
              iconColor: Colors.green,
              title: 'Tus Puntos Fuertes:',
              content:
                  'Has demostrado una comprensión clara del método fundamental para resolver ecuaciones lineales (despejar la incógnita). Los ejercicios 1 y 2, que son los más directos, están resueltos de forma impecable, lo que muestra que manejas con soltura las operaciones básicas como la regla de la suma y del producto.',
            ),

            _buildAdviceCard(
              icon: Icons.trending_up,
              iconColor: Colors.red,
              title: 'Áreas de Mejora & Consejos Prácticos:',
              content:
                  'El punto donde puedes enfocarte para llevar tu calificación al siguiente nivel es en la metodología y el cuidado con los detalles. Los pequeños errores suelen ocurrir por prisas o falta de verificación.',
            ),

            _buildExerciseCard(
              title: 'Ejercicio 3 (Ecuación con paréntesis): 3(2x - 5) = 4x + 1',
              points: [
                'Tu desarrollo probablemente fue: 6x - 15 = 4x + 1 -> 6x - 4x = 1 + 15 -> 2x = 16 -> x = 8.',
                'Análisis: El error común aquí es un fallo en la distribución (firmar mal un término dentro del paréntesis) o al agrupar los términos semejantes.',
                'Consejo: Después de distribuir, haz una pausa para comprobar que todos los signos son correctos antes de pasar términos de lado.',
              ],
            ),

            _buildExerciseCard(
              title: 'Ejercicio 4 (Ecuación con fracciones): (x-2)/3 = x - 4',
              points: [
                'Tu desarrollo probablemente fue: Multiplicar en cruz o por el mínimo común múltiplo. Un error frecuente es olvidar multiplicar todos y cada uno de los términos por el denominador común.',
                'Análisis: Posiblemente al eliminar el denominador, no aplicaste la multiplicación correctamente al término x -4, que en realidad es (x-4)/1.',
                'Consejo clave: ¡Verifica siempre tu solución! Sustituye la x que obtuviste en la ecuación original. Si no se cumple la igualdad, revisa paso a paso tu procedimiento.',
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: AppBarComponents.buildBottomNavBar(context, 0, noHighlight: true),
    );
  }

  Widget _buildAdviceCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 245, 245, 1.0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF0984E3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard({
    required String title,
    required List<String> points,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 245, 245, 1.0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF0984E3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          ...points.map((point) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        point,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}