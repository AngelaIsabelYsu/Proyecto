import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/appbar.dart' as appbar_file;
import 'podio.dart';
import 'consejo_ia.dart';
import '../../services/gemas_service.dart';
import '../../widgets/menu.dart';

class EjerciciosCompletosScreen extends StatefulWidget {
  final int totalGemas;
  
  const EjerciciosCompletosScreen({
    super.key,
    required this.totalGemas,
  });

  @override
  State<EjerciciosCompletosScreen> createState() => _EjerciciosCompletosScreenState();
}

class _EjerciciosCompletosScreenState extends State<EjerciciosCompletosScreen> {
  final int puntajeMaximo = 20;
  int get puntajeActual => _ejercicios.where((e) => e['completado'] == true).length * 5;

  final List<Map<String, dynamic>> _ejercicios = [
    {'numero': 1, 'titulo': 'Ejercicio', 'completado': true},
    {'numero': 2, 'titulo': 'Ejercicio', 'completado': true},
    {'numero': 3, 'titulo': 'Ejercicio', 'completado': true},
    {'numero': 4, 'titulo': 'Ejercicio', 'completado': true},
  ];

  @override
  void initState() {
    super.initState();
    _agregarGemasAlServicio();
  }

  void _agregarGemasAlServicio() {
    final gemasService = Provider.of<GemasService>(context, listen: false);
    gemasService.agregarGemas(widget.totalGemas);
  }

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
      drawer: MenuComponents.buildDrawer(context, currentScreen: ''),
      appBar: appbar_file.AppBarComponents.buildAppBar(
        context, 
        'SEM 1:Derivadas y sus Aplicaciones'
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 5),
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFB3E5FC), 
                    Color(0xFF81D4FA), 
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0000FF).withAlpha(60),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: const Color(0xFF4FC3F7),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Total de gemas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF01579B), 
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF000000).withAlpha(20),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border: Border.all(
                        color: const Color(0xFF4FC3F7),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '💎',
                          style: TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${widget.totalGemas}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF01579B), 
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  const Text(
                    '¡Felicidades! Has completado todos los ejercicios',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF01579B), 
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF42A5F5), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF000000).withAlpha(15),
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
                
                const SizedBox(width: 10),
                
                Image.asset(
                  'assets/images/llama.png',
                  width: 200,
                  height: 200,
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 160,
                      height: 160,
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
            
            const SizedBox(height: 15),
            
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _ejercicios.length,
              itemBuilder: (context, index) {
                final ejercicio = _ejercicios[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEB3B),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF000000).withAlpha(15),
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
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Completo',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xFF4DD0E1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            
            const SizedBox(height: 12),
            
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _verPuntuacion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC143C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
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
                ),
                
                const SizedBox(width: 12),
                
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _verConsejoIA,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC143C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
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
                ),
              ],
            ),
            
            const SizedBox(height: 10),
          ],
        ),
      ),
      
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 1),
    );
  }
}