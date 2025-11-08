import 'package:flutter/material.dart';
import '../widgets/appbar.dart' as appbar_file;
import '../widgets/menu.dart' as menu_file;
import '../achievements/logros.dart' as logros;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF74B9FF),
      
      // DRAWER USANDO COMPONENTE REUTILIZABLE CON ALIAS
      drawer: menu_file.MenuComponents.buildDrawer(context),
      
      body: Container(
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
        child: Column(
          children: [
            // APPBAR USANDO COMPONENTE REUTILIZABLE (CORREGIDO)
            appbar_file.AppBarComponents.buildAppBar(context, 'Mi Perfil'),
            
            Expanded(
              child: FutureBuilder<ProfileData>(
                future: _fetchProfileData(),
                builder: (context, snapshot) {
                  // Si está cargando, muestra la interfaz vacía pero sin loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildEmptyProfile(); // Interfaz vacía temporal
                  }

                  if (snapshot.hasError) {
                    return _ProfileErrorState(error: snapshot.error.toString());
                  }

                  final profileData = snapshot.data!;
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // IMAGEN PERFIL
                        _ProfileImageSection(
                          profileImage: profileData.profileImage,
                          onEditPressed: _showEditProfileDialog,
                        ),
                        const SizedBox(height: 30),
                        
                        // CARD PRINCIPAL
                        _MainCardSection(profileData: profileData),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      
      // BOTTOM NAVIGATION BAR USANDO COMPONENTE REUTILIZABLE (CORREGIDO)
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 3),
    );
  }

  // Interfaz vacía mientras carga (sin loading visible)
  Widget _buildEmptyProfile() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _ProfileImageSection(
            profileImage: 'assets/images/perfil.png',
            onEditPressed: _showEditProfileDialog,
          ),
          const SizedBox(height: 30),
          _MainCardSection(
            profileData: ProfileData(
              id: '',
              name: '',
              lastName: '',
              profileImage: '',
              joinDate: '',
              cycle: '',
              rewards: [],
            ),
          ),
        ],
      ),
    );
  }

  // Simulación de llamada a API - Reemplazar con implementación real
  Future<ProfileData> _fetchProfileData() async {
    // Simular delay de red MUY CORTO o usar datos en cache
    await Future.delayed(const Duration(milliseconds: 100));
    
    // Datos de ejemplo - reemplazar con respuesta real de API
    return ProfileData(
      id: '7589654',
      name: 'Angela',
      lastName: 'Gatito',
      profileImage: 'assets/images/perfil.png',
      joinDate: 'junio de 2025',
      cycle: 'Sexto Ciclo',
      rewards: [
        ProfileReward(
          id: '1',
          emoji: '🥇',
          title: 'Primer Lugar',
          description: 'Matemáticas Avanzadas',
          earnedAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
        ProfileReward(
          id: '2',
          emoji: '⭐',
          title: 'Estrella Semanal',
          description: '10 lecciones completadas',
          earnedAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        ProfileReward(
          id: '3',
          emoji: '🏆',
          title: 'Campeón Álgebra',
          description: 'Dominio total alcanzado',
          earnedAt: DateTime.now().subtract(const Duration(days: 10)),
        ),
      ],
    );
  }

  // DIÁLOGO EDITAR PERFIL
  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<ProfileData>(
          future: _fetchProfileData(),
          builder: (context, snapshot) {
            final profileData = snapshot.data;
            
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                'Editar Perfil',
                style: TextStyle(
                  color: Color(0xFF0984E3),
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: TextEditingController(text: profileData?.name ?? ''),
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: TextEditingController(text: profileData?.lastName ?? ''),
                      decoration: InputDecoration(
                        labelText: 'Apellidos',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: TextEditingController(text: profileData?.cycle ?? ''),
                      decoration: InputDecoration(
                        labelText: 'Ciclo',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _updateProfile();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0984E3),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Método para actualizar perfil - Implementar con API real
  void _updateProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil actualizado correctamente'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

// ==========================================
// COMPONENTES DE UI (ORIGINALES)
// ==========================================

// SECCIÓN IMAGEN PERFIL
class _ProfileImageSection extends StatelessWidget {
  final String profileImage;
  final VoidCallback onEditPressed;

  const _ProfileImageSection({
    required this.profileImage,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Decoración
        Container(
          width: 180,
          height: 180,
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
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        // Imagen
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 4,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              profileImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey[600],
                  ),
                );
              },
            ),
          ),
        ),
        // Botón editar
        Positioned(
          bottom: 5,
          child: GestureDetector(
            onTap: onEditPressed,
            child: Container(
              width: 50,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4D000000),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.edit,
                color: Color(0xFF0984E3),
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// CARD PRINCIPAL
class _MainCardSection extends StatelessWidget {
  final ProfileData profileData;

  const _MainCardSection({required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF74B9FF),
            Color(0xFF0984E3),
          ],
          stops: [0.0, 0.8],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // INFORMACIÓN
          _InfoSection(profileData: profileData),
          const SizedBox(height: 25),
          
          // RECOMPENSAS
          _RewardsSection(rewards: profileData.rewards),
        ],
      ),
    );
  }
}

// SECCIÓN INFORMACIÓN
class _InfoSection extends StatelessWidget {
  final ProfileData profileData;

  const _InfoSection({required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              'Información Personal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _InfoRow(emoji: '👤', label: 'Nombre:', value: profileData.name),
        _InfoRow(emoji: '👥', label: 'Apellidos:', value: profileData.lastName),
        _InfoRow(emoji: '📅', label: 'Se unió en:', value: profileData.joinDate),
        _InfoRow(emoji: '🎓', label: 'Ciclo:', value: profileData.cycle),
      ],
    );
  }
}

// FILA INFORMACIÓN
class _InfoRow extends StatelessWidget {
  final String emoji;
  final String label;
  final String value;

  const _InfoRow({
    required this.emoji,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// SECCIÓN RECOMPENSAS
class _RewardsSection extends StatelessWidget {
  final List<ProfileReward> rewards;

  const _RewardsSection({required this.rewards});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.card_giftcard,
                  color: Colors.amber[100],
                  size: 24,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Mis Recompensas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            // Botón ver
            SizedBox(
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const logros.AchievementsScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0984E3),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  'Ver',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        // Lista recompensas
        Column(
          children: rewards.map((reward) => Column(
            children: [
              _RewardItem(reward: reward),
              const SizedBox(height: 10),
            ],
          )).toList(),
        ),
      ],
    );
  }
}

// ITEM RECOMPENSA
class _RewardItem extends StatelessWidget {
  final ProfileReward reward;

  const _RewardItem({required this.reward});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0x33FFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x4DFFFFFF)),
      ),
      child: Row(
        children: [
          Text(
            reward.emoji,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reward.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reward.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xCCFFFFFF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// ESTADO DE ERROR (EXISTENTE)
// ==========================================

class _ProfileErrorState extends StatelessWidget {
  final String error;

  const _ProfileErrorState({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.white),
          const SizedBox(height: 16),
          const Text(
            'Error al cargar el perfil',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Aquí puedes agregar lógica para reintentar
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF0984E3),
            ),
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// MODELOS DE DATOS PARA API (EXISTENTES)
// ==========================================

class ProfileData {
  final String id;
  final String name;
  final String lastName;
  final String profileImage;
  final String joinDate;
  final String cycle;
  final List<ProfileReward> rewards;

  ProfileData({
    required this.id,
    required this.name,
    required this.lastName,
    required this.profileImage,
    required this.joinDate,
    required this.cycle,
    required this.rewards,
  });
}

class ProfileReward {
  final String id;
  final String emoji;
  final String title;
  final String description;
  final DateTime earnedAt;

  ProfileReward({
    required this.id,
    required this.emoji,
    required this.title,
    required this.description,
    required this.earnedAt,
  });
}