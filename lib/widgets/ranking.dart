import 'package:flutter/material.dart';
import '../widgets/appbar.dart' as appbar_file;


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
  String? selectedCareer;
  bool _isCareerDropdownOpen = false;

  final List<Map<String, dynamic>> careers = [
    {'name': 'Administración y Emprendimiento de Negocios Digitales', 'icon': Icons.business},
    {'name': 'Marketing Digital Analítico', 'icon': Icons.analytics},
    {'name': 'Diseño Industrial', 'icon': Icons.design_services},
    {'name': 'Tecnología de la Producción', 'icon': Icons.precision_manufacturing},
    {'name': 'Producción y Gestión Industrial', 'icon': Icons.factory},
    {'name': 'Logística Digital Integrada', 'icon': Icons.local_shipping},
    {'name': 'Gestión de Seguridad y Salud en el Trabajo', 'icon': Icons.health_and_safety},
    {'name': 'Topografía y Geomática', 'icon': Icons.public},
    {'name': 'Procesos Químicos y Metalúrgicos', 'icon': Icons.science},
    {'name': 'Operaciones Mineras', 'icon': Icons.hardware},
    {'name': 'Operación de Plantas de Procesamiento de Minerales', 'icon': Icons.settings_applications},
    {'name': 'Mantenimiento de Equipo Pesado', 'icon': Icons.construction},
    {'name': 'Mecatrónica y Gestión Automotriz', 'icon': Icons.car_repair},
    {'name': 'Gestión y Mantenimiento de Maquinaria Pesada', 'icon': Icons.build_circle},
    {'name': 'Aviónica y Mecánica Aeronáutica', 'icon': Icons.flight},
    {'name': 'Mantenimiento y Gestión de Plantas Industriales', 'icon': Icons.settings},
    {'name': 'Tecnología Mecánica Eléctrica', 'icon': Icons.electrical_services},
    {'name': 'Ciberseguridad y Auditoría Informática', 'icon': Icons.security},
    {'name': 'Diseño y Desarrollo de Software', 'icon': Icons.code},
    {'name': 'Diseño y Desarrollo de Simuladores y Videojuegos', 'icon': Icons.gamepad},
    {'name': 'Administración de Redes y Comunicaciones', 'icon': Icons.wifi},
    {'name': 'Big Data y Ciencia de Datos', 'icon': Icons.data_usage},
    {'name': 'Modelado y Animación Digital', 'icon': Icons.animation},
  ];

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

  Widget _buildCareerSelector() {
    if (_selectedTabIndex != 1) return const SizedBox.shrink();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isCareerDropdownOpen = !_isCareerDropdownOpen;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: _isCareerDropdownOpen 
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      )
                    : BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Row(
                children: [
                  Icon(
                    selectedCareer != null 
                        ? careers.firstWhere((c) => c['name'] == selectedCareer)['icon'] as IconData
                        : Icons.school,
                    color: Colors.blue.shade700,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      selectedCareer ?? 'Selecciona una carrera',
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    _isCareerDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: Colors.blue.shade700,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          if (_isCareerDropdownOpen)
            Container(
              constraints: const BoxConstraints(maxHeight: 300),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                border: Border.all(color: Colors.blue.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: careers.length,
                itemBuilder: (context, index) {
                  final career = careers[index];
                  final isSelected = selectedCareer == career['name'];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedCareer = career['name'];
                        _isCareerDropdownOpen = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.shade50 : Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            career['icon'] as IconData,
                            size: 20,
                            color: isSelected ? const Color(0xFF0984E3) : Colors.grey.shade600,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              career['name'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                color: isSelected ? const Color(0xFF0984E3) : const Color(0xFF2D3436),
                              ),
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: Color(0xFF0984E3),
                              size: 18,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

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
          Expanded(
            child: Text(
              entry.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
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
      appBar: appbar_file.AppBarComponents.buildAppBar(context, 'Ranking', currentScreen: 'ranking'),
      drawer: appbar_file.AppBarComponents.buildMenuDrawer(context, currentScreen: 'ranking'), // Drawer añadido
      body: Column(
        children: [
          _buildTabs(),
          _buildCareerSelector(),
          Expanded(
            child: (_selectedTabIndex == 1 && selectedCareer == null)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.school_outlined,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Selecciona una carrera',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'para ver el ranking',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
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
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 0, noHighlight: true),
    );
  }
}