import 'package:flutter/material.dart';
import '../widgets/appbar.dart' as appbar_file;
import '../widgets/menu.dart' as menu_file;

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
      
      // APPBAR
      appBar: appbar_file.AppBarComponents.buildAppBar(context, 'Ranking'),
      
      // MENÚ LATERAL
      drawer: menu_file.MenuComponents.buildDrawer(context, currentScreen: 'ranking'),
      
      // CONTENIDO PRINCIPAL
      body: Column(
        children: [
          // TABS SELECCIÓN
          _buildTabs(),
          
          // HEADER INFORMACIÓN
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

      // NAVEGACIÓN INFERIOR
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 0, noHighlight: true),
    );
  }
}