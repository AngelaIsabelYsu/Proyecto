import 'package:flutter/material.dart';
import '../widgets/appbar.dart' as appbar_file;
import '../widgets/menu.dart' as menu_file;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_file.AppBarComponents.buildAppBar(context, 'Mi Perfil'),
      drawer: menu_file.MenuComponents.buildDrawer(context),
      body: FutureBuilder<ProfileData>(
        future: _fetchProfileData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildEmptyProfile(); 
          }

          if (snapshot.hasError) {
            return _ProfileErrorState(error: snapshot.error.toString());
          }

          final profileData = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _ProfileImageSection(
                  profileImage: profileData.profileImage,
                  onEditPressed: _showEditProfileDialog,
                ),
                const SizedBox(height: 30),
                _MainCardSection(profileData: profileData),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 3),
    );
  }

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
              email: '',
              phone: '',
              gender: '',
              career: '',
              profileImage: '',
              joinDate: '',
              cycle: '',
            ),
          ),
        ],
      ),
    );
  }

  Future<ProfileData> _fetchProfileData() async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    return ProfileData(
      id: '7589654',
      name: 'Angela',
      lastName: 'Gatito',
      email: 'angela.gatito@tecsup.edu.pe',
      phone: '+51 987 654 321',
      gender: 'Femenino',
      career: 'Diseño y Desarrollo de Software',
      profileImage: 'assets/images/perfil.png',
      joinDate: 'junio de 2025',
      cycle: 'Sexto Ciclo',
    );
  }

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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: TextEditingController(text: profileData?.lastName ?? ''),
                      decoration: InputDecoration(
                        labelText: 'Apellidos',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: TextEditingController(text: profileData?.email ?? ''),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: TextEditingController(text: profileData?.phone ?? ''),
                      decoration: InputDecoration(
                        labelText: 'Teléfono',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: TextEditingController(text: profileData?.gender ?? ''),
                      decoration: InputDecoration(
                        labelText: 'Género',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: TextEditingController(text: profileData?.career ?? ''),
                      decoration: InputDecoration(
                        labelText: 'Carrera',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: TextEditingController(text: profileData?.cycle ?? ''),
                      decoration: InputDecoration(
                        labelText: 'Ciclo',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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

  void _updateProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil actualizado correctamente'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

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
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF0984E3), width: 3),
            boxShadow: const [
              BoxShadow(color: Color(0x33000000), blurRadius: 10, spreadRadius: 2),
            ],
          ),
        ),
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF0984E3), width: 4),
          ),
          child: ClipOval(
            child: Image.asset(
              profileImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.person, size: 60, color: Colors.grey[600]),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          child: GestureDetector(
            onTap: onEditPressed,
            child: Container(
              width: 50,
              height: 25,
              decoration: BoxDecoration(
                color: const Color(0xFF0984E3),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                boxShadow: const [
                  BoxShadow(color: Color(0x4D000000), blurRadius: 6, offset: Offset(0, 3)),
                ],
              ),
              child: const Icon(Icons.edit, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }
}

class _MainCardSection extends StatelessWidget {
  final ProfileData profileData;

  const _MainCardSection({required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF0984E3), width: 2),
        boxShadow: const [
          BoxShadow(color: Color(0x1A000000), blurRadius: 15, offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          _InfoSection(profileData: profileData),
        ],
      ),
    );
  }
}

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
            const Icon(Icons.person_outline, color: Color(0xFF0984E3), size: 22),
            const SizedBox(width: 8),
            Text(
              'Información Personal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0984E3),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _InfoRow(emoji: '👤', label: 'Nombre:', value: profileData.name),
        _InfoRow(emoji: '👥', label: 'Apellidos:', value: profileData.lastName),
        _InfoRow(emoji: '📧', label: 'Email:', value: profileData.email),
        _InfoRow(emoji: '📱', label: 'Teléfono:', value: profileData.phone),
        _InfoRow(emoji: '⚧️', label: 'Género:', value: profileData.gender),
        _InfoRow(emoji: '🎓', label: 'Carrera:', value: profileData.career),
        _InfoRow(emoji: '📅', label: 'Se unió en:', value: profileData.joinDate),
        _InfoRow(emoji: '🔄', label: 'Ciclo:', value: profileData.cycle),
      ],
    );
  }
}

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
          SizedBox(width: 30, child: Text(emoji, style: const TextStyle(fontSize: 16))),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF0984E3)),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileErrorState extends StatelessWidget {
  final String error;

  const _ProfileErrorState({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Color(0xFF0984E3)),
          const SizedBox(height: 16),
          const Text(
            'Error al cargar el perfil',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0984E3)),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0984E3),
              foregroundColor: Colors.white,
            ),
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}

class ProfileData {
  final String id;
  final String name;
  final String lastName;
  final String email;
  final String phone;
  final String gender;
  final String career;
  final String profileImage;
  final String joinDate;
  final String cycle;

  ProfileData({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.career,
    required this.profileImage,
    required this.joinDate,
    required this.cycle,
  });
}