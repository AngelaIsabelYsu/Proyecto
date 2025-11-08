import 'package:flutter/material.dart';
import '../widgets/appbar.dart' as appbar_file;
import '../widgets/menu.dart' as menu_file;

class EstadisticasScreen extends StatefulWidget {
  const EstadisticasScreen({super.key});

  @override
  State<EstadisticasScreen> createState() => _EstadisticasScreenState();
}

class _EstadisticasScreenState extends State<EstadisticasScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      // APPBAR CORREGIDO - sin el parámetro currentScreen
      appBar: appbar_file.AppBarComponents.buildAppBar(context, 'Estadísticas'),
      
      // DRAWER CORREGIDO - manteniendo currentScreen si está definido en MenuComponents
      drawer: menu_file.MenuComponents.buildDrawer(context, currentScreen: 'estadisticas'),
      
      // CONTENIDO PRINCIPAL - ESTADÍSTICAS
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // EVOLUCION DE PUNTAJE Y TIEMPO DEDICADO
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildScoreEvolution(),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: _buildTimeDedicated(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // PROGRESO Y LLAMA 
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildProgress(),
                ),
                const SizedBox(width: 16),
                _buildLlamaImage(),
              ],
            ),
            const SizedBox(height: 20),
            
            // TASA DE REPETICIÓN
            _buildRepetitionRate(),
          ],
        ),
      ),

      // BOTTOM NAVIGATION BAR SIN RESALTADO
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 0, noHighlight: true),
    );
  }

  // GRÁFICO DE EVOLUCIÓN DE PUNTAJE
  Widget _buildScoreEvolution() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Evolución de tu puntaje en evaluaciones',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          const SizedBox(height: 20),
          
          // GRÁFICO DE BARRAS
          SizedBox(
            height: 200,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text('100%', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const Text('80%', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const Text('60%', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const Text('40%', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const Text('0%', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          // LÍNEAS GUÍA DEL GRÁFICO
                          Column(
                            children: [
                              SizedBox(height: 40, child: const Divider(color: Colors.grey)),
                              SizedBox(height: 40, child: const Divider(color: Colors.grey)),
                              SizedBox(height: 40, child: const Divider(color: Colors.grey)),
                              SizedBox(height: 40, child: const Divider(color: Colors.grey)),
                              SizedBox(height: 40, child: const Divider(color: Colors.grey)),
                            ],
                          ),
                          
                          // BARRAS DE DATOS
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _buildDataPoint(40, 'Mar'),
                                _buildDataPoint(60, 'Apr'),
                                _buildDataPoint(80, 'May'),
                                _buildDataPoint(95, 'Jun'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // PUNTO DE DATO INDIVIDUAL PARA EL GRÁFICO
  Widget _buildDataPoint(int percentage, String month) {
    double height = (percentage / 100) * 160;
    return Column(
      children: [
        Container(
          width: 30,
          height: height,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF74B9FF), Color(0xFF0984E3)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          month,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // CARD DE TIEMPO DEDICADO
  Widget _buildTimeDedicated() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tiempo dedicado',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F4FF),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.access_time_filled,
                    color: Color(0xFF0984E3),
                    size: 45,
                  ),
                ),
                const SizedBox(height: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '1 h 45 min',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3436),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Por sesión',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  // CARD DE PROGRESO 
  Widget _buildProgress() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Progreso',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          const SizedBox(height: 15),
          
          // BARRA DE PROGRESO Y DETALLES
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '65% completado',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF2D3436),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F4FF),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  widthFactor: 0.65,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF74B9FF), Color(0xFF0984E3)],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Cálculo y estadística',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF2D3436),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // IMAGEN DE LLAMA 
  Widget _buildLlamaImage() {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset(
        'assets/images/llama.png',
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFEAA7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.emoji_emotions,
              color: Color(0xFFE17055),
              size: 80,
            ),
          );
        },
      ),
    );
  }

  // CARD DE TASA DE REPETICIÓN
  Widget _buildRepetitionRate() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tasa de repetición',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          SizedBox(height: 10),
          Text(
            '¡Buen trabajo! Tu tasa de repetición indica que practicas lo suficiente para dominar los temas.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}