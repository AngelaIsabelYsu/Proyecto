import 'package:flutter/material.dart';
import 'estadisticas.dart';
import 'ranking.dart';
import 'avatar/avatar.dart';

class MenuComponents {
  static Widget buildDrawer(BuildContext context, {String currentScreen = ''}) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF64B5F6),  // Azul más claro
              Color(0xFF42A5F5),  // Azul medio
            ],
          ),
        ),
        child: Column(
          children: [
            _buildDrawerHeader(),
            
            const SizedBox(height: 20),
            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildMenuButton(
                      context: context,
                      icon: Icons.leaderboard,
                      label: 'Ranking',
                      isSelected: currentScreen == 'ranking',
                      onTap: () {
                        Navigator.pop(context);
                        if (currentScreen != 'ranking') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RankingScreen(),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildMenuButton(
                      context: context,
                      icon: Icons.bar_chart,
                      label: 'Estadísticas',
                      isSelected: currentScreen == 'estadisticas',
                      onTap: () {
                        Navigator.pop(context);
                        if (currentScreen != 'estadisticas') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EstadisticasScreen(),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildMenuButton(
                      context: context,
                      icon: Icons.face,
                      label: 'Avatar',
                      isSelected: currentScreen == 'avatar',
                      onTap: () {
                        Navigator.pop(context);
                        if (currentScreen != 'avatar') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AvatarScreen(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B6B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Cerrar sesión',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  static Widget _buildDrawerHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/perfil.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.white,
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Color(0xFF42A5F5), // Azul más claro
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 15),
          
          const Text(
            'Angela',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0x33FFFFFF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'ID 7589654',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildMenuButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: isSelected 
                ? const Color(0x66FFFFFF)
                : const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isSelected
                  ? Colors.white
                  : const Color(0x4DFFFFFF),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected 
                        ? FontWeight.bold
                        : FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: isSelected 
                    ? Colors.white 
                    : const Color(0xB3FFFFFF),
                size: 24,
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
              color: Color(0xFF42A5F5), // Azul más claro
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