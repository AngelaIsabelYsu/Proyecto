import 'package:flutter/material.dart';
import '../widgets/appbar.dart' as appbar_file;
import '../auth/login/login_screen.dart';
import 'avatar/avatar.dart';
import '../widgets/estadisticas.dart';

// MODELO RANKING
class RankingEntry {
  final int rank;
  final String name;
  final int score;

  RankingEntry({required this.rank, required this.name, required this.score});
}

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  int _selectedTabIndex = 0;

  // DATOS CARRERA
  final List<RankingEntry> _carreraRankingData = [
    RankingEntry(rank: 1, name: 'Ana García', score: 1920),
    RankingEntry(rank: 2, name: 'Carlos Rodríguez', score: 1885),
    RankingEntry(rank: 3, name: 'María López', score: 1850),
    RankingEntry(rank: 4, name: 'Diego Silva', score: 1820),
    RankingEntry(rank: 5, name: 'Laura Mendoza', score: 1780),
    RankingEntry(rank: 6, name: 'Javier Ruiz', score: 1755),
    RankingEntry(rank: 7, name: 'Sofía Castro', score: 1720),
    RankingEntry(rank: 8, name: 'Miguel Torres', score: 1695),
    RankingEntry(rank: 9, name: 'Elena Vargas', score: 1670),
    RankingEntry(rank: 10, name: 'Ricardo Paredes', score: 1645),
  ];

  // DATOS TECSUP
  final List<RankingEntry> _tecsupRankingData = [
    RankingEntry(rank: 1, name: 'Andrea Rojas', score: 2150),
    RankingEntry(rank: 2, name: 'Fernando Díaz', score: 2080),
    RankingEntry(rank: 3, name: 'Gabriela Soto', score: 2055),
    RankingEntry(rank: 4, name: 'Roberto Paz', score: 2020),
    RankingEntry(rank: 5, name: 'Camila Flores', score: 1985),
    RankingEntry(rank: 6, name: 'Luis Herrera', score: 1950),
    RankingEntry(rank: 7, name: 'Daniela Ríos', score: 1925),
    RankingEntry(rank: 8, name: 'José Quispe', score: 1900),
    RankingEntry(rank: 9, name: 'Valeria Cruz', score: 1875),
    RankingEntry(rank: 10, name: 'Arturo León', score: 1850),
  ];

 
  // TABS SELECCIÓN
  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // TAB TECSUP
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedTabIndex = 0;
                  });
                },
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(12),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _selectedTabIndex == 0 
                        ? const Color(0xFF0984E3) 
                        : Colors.transparent,
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Tecsup',
                      style: TextStyle(
                        color: _selectedTabIndex == 0 
                            ? Colors.white 
                            : Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // TAB CARRERA
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedTabIndex = 1;
                  });
                },
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(12),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _selectedTabIndex == 1 
                        ? const Color(0xFF0984E3) 
                        : Colors.transparent,
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Carrera',
                      style: TextStyle(
                        color: _selectedTabIndex == 1 
                            ? Colors.white 
                            : Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // FILA RANKING
  Widget _buildRankingRow(RankingEntry entry) {
    bool isTopThree = entry.rank <= 3;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isTopThree ? Colors.amber.shade200 : Colors.grey.shade200,
          width: isTopThree ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // NÚMERO RANKING
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isTopThree ? Colors.amber.shade500 : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${entry.rank}',
                style: TextStyle(
                  color: isTopThree ? Colors.white : Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // NOMBRE
          Expanded(
            child: Text(
              entry.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          // PUNTAJE
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${entry.score} pts',
              style: TextStyle(
                color: Colors.blue.shade800,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      // APPBAR IMPORTADO - usando AppBarComponents
      appBar: appbar_file.AppBarComponents.buildAppBar(context, 'Ranking'),
      
      // MENÚ LATERAL
      drawer: _buildCustomDrawer(context),
      
      // CONTENIDO
      body: Column(
        children: [
          // TABS
          _buildTabs(),
          
          // HEADER
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.school, color: Colors.blue.shade700, size: 20),
                const SizedBox(width: 8),
                Text(
                  _selectedTabIndex == 1 
                      ? 'Diseño y Desarrollo de Software'
                      : 'Todas las carreras - Tecsup',
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          // LISTA RANKING
          Expanded(
            child: ListView.builder(
              itemCount: _selectedTabIndex == 1 
                  ? _carreraRankingData.length 
                  : _tecsupRankingData.length,
              itemBuilder: (context, index) {
                final data = _selectedTabIndex == 1 
                    ? _carreraRankingData[index] 
                    : _tecsupRankingData[index];
                return _buildRankingRow(data);
              },
            ),
          ),
        ],
      ),

      // NAVBAR INFERIOR IMPORTADO - SIN RESALTADO
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 0, noHighlight: true),
    );
  }

  // MENÚ LATERAL
  Widget _buildCustomDrawer(BuildContext context) {
    
    // OPCIÓN MENÚ
    Widget drawerOption(String title, IconData icon, VoidCallback onTap) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromRGBO(255, 255, 255, 0.2),
                border: Border.all(
                  color: const Color.fromRGBO(255, 255, 255, 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white, size: 22),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color.fromRGBO(255, 255, 255, 0.7),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    
    return Drawer(
      child: Container(
        color: const Color(0xFF0984E3),
        child: SizedBox(
          width: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 70.0, bottom: 30.0),
                decoration: const BoxDecoration(
                  color: Color(0xFF0984E3),
                ),
                child: Column(
                  children: [
                    // AVATAR
                    Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 167, 167, 167),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(0, 0, 0, 0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/perfil.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFF0984E3),
                              child: const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Angela',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'ID 7589654',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // OPCIONES
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: const Color(0xFF0984E3),
                  child: Column(
                    children: [
                      drawerOption('Ranking', Icons.leaderboard_rounded, () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RankingScreen()),
                        );
                      }),
                      drawerOption('Estadísticas', Icons.bar_chart_rounded, () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EstadisticasScreen()),
                        );
                      }),
                      drawerOption('Avatar', Icons.palette_rounded, () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AvatarScreen()),
                        );
                      }),
                      
                      const Spacer(),
                      
                      // BOTÓN CERRAR SESIÓN
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                              );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFFF6B6B), Color(0xFFEE5A52)],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF6B6B).withAlpha(77),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.logout_rounded, color: Colors.white, size: 20),
                                  SizedBox(width: 12),
                                  Text(
                                    'Cerrar sesión',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}