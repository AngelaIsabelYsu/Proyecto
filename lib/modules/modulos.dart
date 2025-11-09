import 'package:flutter/material.dart';
import '../widgets/menu.dart' as menu_file;
import '../modules/temario.dart';
import '../widgets/appbar.dart' as appbar_file;

class ModuloScreen extends StatefulWidget {
  const ModuloScreen({super.key});

  @override
  State<ModuloScreen> createState() => _ModuloScreenState();
}

class _ModuloScreenState extends State<ModuloScreen> {
  final int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_file.AppBarComponents.buildAppBar(context, 'Módulos'),
      drawer: menu_file.MenuComponents.buildDrawer(context),
      body: _buildBody(),
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, _selectedIndex),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 03),
          _buildLlamaImage(),
          const SizedBox(height: 3),
          _buildSubtitle(),
          const SizedBox(height: 15),
          _buildModuleButtons(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildLlamaImage() {
    return Image.asset(
      'assets/images/llama.png',
      height: 240,
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      '¡El conocimiento te llama 🔥!',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w300,
        color: Color(0xFF333333),
      ),
    );
  }

  Widget _buildModuleButtons() {
    return Column(
      children: [
        // Módulo 1: Cálculo y Estadística
        _buildCourseButton(
          title: 'Cálculo y Estadística',
          backgroundColor: const Color(0xFFD92A2A), 
          onPressed: () => _navigateToTemario('calculus'),
        ),
        const SizedBox(height: 16),
        // Módulo 2: Aplicaciones
        _buildCourseButton(
          title: 'Aplicaciones de\nCálculo y Estadística',
          backgroundColor: const Color(0xFF4CAF50), 
          onPressed: () => _navigateToTemario('applications'),
        ),
      ],
    );
  }

  Widget _buildCourseButton({
    required String title,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 160),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        elevation: 5,
        shadowColor: backgroundColor.withAlpha(102),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w300,
          height: 1.3,
          color: Colors.white,
        ),
      ),
    );
  }

  void _navigateToTemario(String moduleType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TemarioScreen(moduleType: moduleType),
      ),
    );
  }
}