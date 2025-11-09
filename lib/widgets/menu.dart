import 'package:flutter/material.dart';
import 'estadisticas.dart';
import 'ranking.dart';
import 'avatar/avatar.dart';

class MenuComponents {
  static Widget buildDrawer(BuildContext context, {String currentScreen = ''}) {
    
    // OPCIÓN MENÚ
    Widget drawerOption(String title, IconData icon, VoidCallback onTap, bool isSelected) {
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
                color: isSelected 
                    ? const Color.fromRGBO(255, 255, 255, 0.3)
                    : const Color.fromRGBO(255, 255, 255, 0.2),
                border: Border.all(
                  color: isSelected
                      ? Colors.white
                      : const Color.fromRGBO(255, 255, 255, 0.3),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white, size: 22),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: isSelected 
                        ? Colors.white 
                        : const Color.fromRGBO(255, 255, 255, 0.7),
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
                      drawerOption(
                        'Ranking', 
                        Icons.leaderboard_rounded, 
                        () {
                          Navigator.pop(context);
                          if (currentScreen != 'ranking') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RankingScreen()),
                            );
                          }
                        },
                        currentScreen == 'ranking'
                      ),
                      drawerOption(
                        'Estadísticas', 
                        Icons.bar_chart_rounded, 
                        () {
                          Navigator.pop(context);
                          if (currentScreen != 'estadisticas') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const EstadisticasScreen()),
                            );
                          }
                        },
                        currentScreen == 'estadisticas'
                      ),
                      drawerOption(
                        'Avatar', 
                        Icons.palette_rounded, 
                        () {
                          Navigator.pop(context);
                          if (currentScreen != 'avatar') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AvatarScreen()),
                            );
                          }
                        },
                        currentScreen == 'avatar'
                      ),
                      
                      const Spacer(),
                      
                      // BOTÓN CERRAR SESIÓN
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              _showLogoutDialog(context);
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

  static void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            '¿Cerrar sesión?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF42A5F5),
            ),
          ),
          content: const Text(
            '¿Estás seguro de que deseas cerrar sesión?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sesión cerrada correctamente'),
                    backgroundColor: Color(0xFF4CAF50),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B6B),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Cerrar sesión',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}