import 'package:flutter/material.dart';
import '../dashboard/dashboard_one.dart';
import '../modules/modulos.dart';
import '../achievements/logros.dart';
import '../profile/perfil.dart';
import '../widgets/menu.dart'; // Importación añadida

class AppBarComponents {
  // AppBar con menú de 3 rayitas
  static AppBar buildAppBar(BuildContext context, String title, {String currentScreen = ''}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF74B9FF),
              Color(0xFF0984E3),
            ],
            stops: [0.0, 0.8],
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
    );
  }

  // Método para construir el Drawer usando MenuComponents
  static Widget buildMenuDrawer(BuildContext context, {String currentScreen = ''}) {
    return MenuComponents.buildDrawer(context, currentScreen: currentScreen);
  }

  // AppBar con flecha de retroceso
  static AppBar buildBackAppBar(BuildContext context, String title) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF74B9FF),
              Color(0xFF0984E3),
            ],
            stops: [0.0, 0.8],
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  // AppBar simple (sin leading icon - para mantener compatibilidad)
  static AppBar buildSimpleAppBar(BuildContext context, String title) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color(0xFF42A5F5),
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  static Widget buildBottomNavBar(BuildContext context, int currentIndex, {bool noHighlight = false}) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF74B9FF),
            Color(0xFF0984E3),
          ],
          stops: [0.0, 0.8],
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: noHighlight ? 0 : currentIndex,
        selectedItemColor: noHighlight ? const Color(0xB3FFFFFF) : Colors.white,
        unselectedItemColor: const Color(0xB3FFFFFF),
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
        onTap: (index) {
          if (index == currentIndex && !noHighlight) return;

          switch (index) {
            case 0:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const DashboardScreen()),
                (route) => false,
              );
              break;
            case 1:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const ModuloScreen()),
                (route) => false,
              );
              break;
            case 2:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AchievementsScreen()),
                (route) => false,
              );
              break;
            case 3:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
                (route) => false,
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 24),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school, size: 24),
            label: 'Módulos',
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
      ),
    );
  }
}