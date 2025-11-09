import 'package:flutter/material.dart';
import '../widgets/appbar.dart' as appbar_file; 
import '../widgets/menu.dart' as menu_file;
import '../achievements/logros.dart'; 
import '../modules/modulos.dart'; 
import '../widgets/estadisticas.dart'; 

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      // APPBAR 
      appBar: appbar_file.AppBarComponents.buildAppBar(context, 'Dashboard'),
      
      // DRAWER 
      drawer: menu_file.MenuComponents.buildDrawer(context),
      
      // CONTENIDO PRINCIPAL
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(),
            const SizedBox(height: 30),
            _buildContinueLearningSection(),
            const SizedBox(height: 30),
            _buildAchievementsSection(), 
            const SizedBox(height: 20),
            _buildProgressReportSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      
      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, _currentIndex),
    );
  }

  // CARD DE BIENVENIDA
  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20), 
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Bienvenido, estudiante!', 
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold, 
                    color: Colors.grey[800]
                  )
                ),
                const SizedBox(height: 8),
                Text(
                  '¿Listo para comenzar nuevos desafíos matemáticos?', 
                  style: TextStyle(
                    fontSize: 14, 
                    color: Colors.grey[600], 
                    height: 1.4
                  )
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 120,
            height: 120, 
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(top: 20),
            child: Image.asset(
              'assets/images/llamitac.png', 
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  // SECCIÓN DE CONTINUAR APRENDIENDO
  Widget _buildContinueLearningSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Continuar aprendiendo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildContinueLearningCard(),
      ],
    );
  }

  // CARD DE CONTINUAR APRENDIENDO
  Widget _buildContinueLearningCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), 
              color: Colors.blue[50],
            ),
            child: Image.asset('assets/images/reglasd.png', fit: BoxFit.contain),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SEM I: Ecuaciones lineales', 
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.grey[800]
                  )
                ),
                const SizedBox(height: 4),
                Text(
                  'Modulo 1 de 5 incompleto', 
                  style: TextStyle(
                    fontSize: 14, 
                    color: Colors.grey[600]
                  )
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue[500], 
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ModuloScreen()),
                );
              },
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  // SECCIÓN DE LOGROS
  Widget _buildAchievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Tus logros', 
            style: TextStyle(
              fontSize: 18, 
              color: Colors.grey[800]
            )
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _buildAchievementCard(
                image: 'assets/images/trofeod.png', 
                title: 'Primer desafío',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AchievementsScreen()),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildAchievementCard(
                image: 'assets/images/modulosd.png', 
                title: 'Módulos',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ModuloScreen()),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildAchievementCard(
                image: 'assets/images/puntajed.png', 
                title: 'Máximo puntaje',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AchievementsScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // CARD DE LOGRO INDIVIDUAL
  Widget _buildAchievementCard({
    required String image, 
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 130,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(image, fit: BoxFit.contain),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SECCIÓN DE INFORME DE PROGRESO
  Widget _buildProgressReportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Informe de progreso', 
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold, 
              color: Colors.grey[800]
            )
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(0, 0, 0, 0.15),
                blurRadius: 15,
                offset: const Offset(0, 8),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue[50], 
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.analytics_outlined, color: Colors.blue[500], size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Análisis de rendimiento completo', 
                      style: TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.grey[800]
                      )
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Revisa tu progreso detallado, estadísticas de aprendizaje y áreas de mejora', 
                style: TextStyle(
                  fontSize: 14, 
                  color: Colors.grey[600], 
                  height: 1.4
                )
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EstadisticasScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[500],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Ver análisis'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}