import 'package:flutter/material.dart';
import '../modules/modulos.dart';
import '../achievements/logros.dart';
import '../profile/perfil.dart';
import '../dashboard/dashboard_one.dart';
import 'historia.dart';

class _TemarioColors {
  static const primaryBlue = Color(0xFF0984E3);
  static const lightBlue = Color(0xFF74B9FF);
  static const red = Color(0xFFD92A2A);
  static const white = Colors.white;
  static const cardBackground = Color(0xFFF5F5F5);
}

class _TemarioTextStyles {
  static const appBarTitle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  
  static const headerTitle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.5,
  );
  
  static const temaTitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: Color(0xFF2D3436),
  );
  
  static const temaNumber = TextStyle(
    color: Colors.white,
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );
}

class TemarioScreen extends StatefulWidget {
  final String moduleType;
  
  const TemarioScreen({
    super.key,
    required this.moduleType,
  });

  @override
  State<TemarioScreen> createState() => _TemarioScreenState();
}

class _TemarioScreenState extends State<TemarioScreen> {
  int _selectedIndex = 1;

  List<Map<String, dynamic>> get _temas {
    if (widget.moduleType == 'applications') {
      return _temasAplicaciones;
    } else {
      return _temasCalculo;
    }
  }

  String get _moduleTitle {
    return widget.moduleType == 'applications' 
      ? 'Aplicaciones de Cálculo y Estadística'
      : 'Cálculo y Estadística';
  }

  final List<Map<String, dynamic>> _temasCalculo = [
    {
      'numero': '1',
      'titulo': 'Ecuaciones Lineales',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '2',
      'titulo': 'Ecuaciones Cuadráticas',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '3',
      'titulo': 'Sistemas de Ecuaciones Lineales',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '4',
      'titulo': 'Geometría del Espacio I (Prisma, Cilindro, Cubo)',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '5',
      'titulo': 'Plano Cartesiano y Ecuación de la Recta',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '6',
      'titulo': 'Proporcionalidad',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '7',
      'titulo': 'Resolución de Triángulos',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '8',
      'titulo': 'Geometría del Espacio II (Cono, Pirámide, Esfera)',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '9',
      'titulo': 'Funciones Lineales y Cuadráticas',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '10',
      'titulo': 'Funciones Exponenciales y Logarítmicas',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '11',
      'titulo': 'Funciones Seno y Coseno',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '12',
      'titulo': 'Funciones por Tramos',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '13',
      'titulo': 'Estadística Básica y Tablas de Frecuencia',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '14',
      'titulo': 'Medidas Estadísticas I',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '15',
      'titulo': 'Medidas Estadísticas II',
      'color': _TemarioColors.cardBackground,
    },
  ];

  final List<Map<String, dynamic>> _temasAplicaciones = [
    {
      'numero': '1',
      'titulo': 'Aplicaciones de Ecuaciones en la Vida Real',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '2',
      'titulo': 'Estadística en Investigación de Mercados',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '3',
      'titulo': 'Cálculo en Ingeniería y Arquitectura',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '4',
      'titulo': 'Análisis de Datos con Herramientas Digitales',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '5',
      'titulo': 'Modelado Matemático en Ciencias Sociales',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '6',
      'titulo': 'Optimización en Logística y Transporte',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '7',
      'titulo': 'Probabilidad en Toma de Decisiones',
      'color': _TemarioColors.cardBackground,
    },
    {
      'numero': '8',
      'titulo': 'Series y Secuencias en Finanzas',
      'color': _TemarioColors.cardBackground,
    },
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ModuloScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AchievementsScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }

  void _onTemaTapped(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoriaScreen(
          numeroSemana: _temas[index]['numero'],
          tituloSemana: _temas[index]['titulo'],
          descripcionSemana: 'Descripción de ${_temas[index]['titulo']}',
          colorSemana: _temas[index]['color'],
          progresoSemana: 0.0,
          totalSemana: 10,
          completadosSemana: 0,
          moduleType: widget.moduleType,
          temaIndex: index,
          temaTitle: _temas[index]['titulo'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_TemarioColors.lightBlue, _TemarioColors.primaryBlue],
            stops: [0.0, 0.8],
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        _moduleTitle,
        style: _TemarioTextStyles.appBarTitle,
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildTemasList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'SEMANAS',
            style: _TemarioTextStyles.headerTitle,
          ),
          const SizedBox(width: 15),
          _buildLlamaImage(),
        ],
      ),
    );
  }

  Widget _buildLlamaImage() {
    return Image.asset(
      'assets/images/llamitac.png',
      height: 50,
      width: 50,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _TemarioColors.primaryBlue.withAlpha(51),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Icon(
            Icons.emoji_emotions,
            color: _TemarioColors.primaryBlue,
            size: 25,
          ),
        );
      },
    );
  }

  Widget _buildTemasList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _TemarioColors.red,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _temas.length,
          itemBuilder: (context, index) {
            return _buildTemaItem(index);
          },
        ),
      ),
    );
  }

  Widget _buildTemaItem(int index) {
    final tema = _temas[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onTemaTapped(index),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: tema['color'] as Color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(13),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildTemaNumber(tema['numero']),
                const SizedBox(width: 10),
                _buildTemaTitle(tema['titulo']),
                const SizedBox(width: 6),
                _buildNavigationArrow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTemaNumber(String numero) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: _TemarioColors.red.withAlpha(76),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'SEM $numero',
        style: _TemarioTextStyles.temaNumber,
      ),
    );
  }

  Widget _buildTemaTitle(String titulo) {
    return Expanded(
      child: Text(
        titulo,
        style: _TemarioTextStyles.temaTitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildNavigationArrow() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: _TemarioColors.red.withAlpha(76),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.white,
        size: 10,
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [_TemarioColors.lightBlue, _TemarioColors.primaryBlue],
          stops: [0.0, 0.8],
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _TemarioColors.white,
        unselectedItemColor: const Color(0xB3FFFFFF),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 24),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school, size: 24),
            label: 'Modulos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events, size: 24),
            label: 'Logros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 24),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}