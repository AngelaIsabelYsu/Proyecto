import 'package:flutter/material.dart';
import '../../widgets/appbar.dart' as appbar_file;
import '../../widgets/menu.dart' as menu_file;
import 'perfilavatar.dart'; 

class AvatarScreen extends StatefulWidget {
  const AvatarScreen({super.key});

  @override
  State<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  // LISTA DE AVATARS
  final List<Map<String, dynamic>> _avatars = [
    {
      'image': 'assets/images/ahipopotamo.png',
      'quote': 'La lógica fluye mejor cuando respiras hondo... como yo en la corriente.',
      'author': 'IGNIX',
      'name': 'Hipopótamo',
      'color': const Color(0xFFFFC1CC),
      'description': 'No corre, ni se apura. Prefiere pensar despacio, como flotando en ideas. Cuando todo parece difícil, él sonríe y dice: "Respira... cada número tiene su ritmo". Su calma ayuda a resolver incluso los ejercicios más rebeldes.',
      'isEquipped': false,
      'customName': 'IGNIX',
      'animalType': 'hipopotamo', 
    },
    {
      'image': 'assets/images/aleon.png',
      'quote': 'Cada problema que resuelves es un rugido más fuerte en tu sistema de logros',
      'author': 'BRIZALI',
      'name': 'León',
      'color': const Color(0xFFFFF4CC),
      'description': 'Siempre creyó que cada problema matemático era una aventura. Cuando un estudiante dudaba, él rugía suve: "¡Tú puedes!" Con su melena brillante y corazón fuerte, enseña que el coraje es la clave para avanzar.',
      'isEquipped': false,
      'customName': 'BRIZALI',
      'animalType': 'leon',
    },
    {
      'image': 'assets/images/aconejo.png',
      'quote': 'Los errores solo hacen que brinques más alto en tu camino al éxito',
      'author': 'DROP!',
      'name': 'Conejo',
      'color': const Color(0xFFD4F4F4),
      'description': 'Brinca de sumas a ecuaciones como si fueran charcos. Aunque a veces se equivoca, nunca se rinde. Él cree que los errores son saltos que te llevan más alto. Su energía contagiosa motiva a aprender más!',
      'isEquipped': false,
      'customName': 'DROP!',
      'animalType': 'conejo',
    },
  ];

  // MÉTODO PARA ACTUALIZAR EL NOMBRE DE UN AVATAR
  void _updateAvatarName(int index, String newName) {
    setState(() {
      _avatars[index]['customName'] = newName;
    });
  }

  // MÉTODO PARA ACTUALIZAR EL ESTADO DE EQUIPADO
  void _updateAvatarEquipped(int index, bool isEquipped) {
    setState(() {
      // Primero desequipamos todos los avatares
      for (var i = 0; i < _avatars.length; i++) {
        _avatars[i]['isEquipped'] = false;
      }
      // Luego equipamos el avatar seleccionado
      _avatars[index]['isEquipped'] = isEquipped;
    });
  }

  // MÉTODO PARA NAVEGAR AL DETALLE DEL AVATAR
  void _navigateToAvatarDetail(int index, Map<String, dynamic> avatar) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AvatarDetailScreen(
          name: avatar['name'] as String,
          authorName: avatar['customName'] as String,
          imagePath: avatar['image'] as String,
          backgroundColor: avatar['color'] as Color,
          description: avatar['description'] as String,
          isEquipped: avatar['isEquipped'] as bool,
          animalType: avatar['animalType'] as String, 
          onNameChanged: (newName) {
            // Cuando se cambia el nombre en perfilavatar.dart, actualizamos aquí
            _updateAvatarName(index, newName);
          },
          onEquippedChanged: (isEquipped) {
            // Cuando se cambia el estado de equipado en perfilavatar.dart
            _updateAvatarEquipped(index, isEquipped);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // APPBAR IMPORTADO
      appBar: appbar_file.AppBarComponents.buildAppBar(context, 'Avatar'),

      // MENÚ LATERAL IMPORTADO
      drawer: menu_file.MenuComponents.buildDrawer(context, currentScreen: 'avatar'),

      // LISTA DE AVATARS
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              itemCount: _avatars.length,
              itemBuilder: (context, index) {
                final avatar = _avatars[index];
                final customName = avatar['customName'] as String;
                final isEquipped = avatar['isEquipped'] as bool;
                
                return GestureDetector(
                  onTap: () {
                    _navigateToAvatarDetail(index, avatar);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: avatar['color'] as Color,
                      borderRadius: BorderRadius.circular(25),
                      border: isEquipped
                          ? Border.all(
                              color: const Color(0xFF4CAF50),
                              width: 3,
                            )
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(20),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                        if (isEquipped)
                          BoxShadow(
                            color: const Color(0xFF4CAF50).withAlpha(100),
                            blurRadius: 20,
                            offset: const Offset(0, 0),
                          ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: Row(
                            children: [
                              // CONTENEDOR DE IMAGEN DEL AVATAR
                              Container(
                                width: 120,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.transparent,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    avatar['image'] as String,
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.high,
                                    isAntiAlias: true,
                                    cacheWidth: 240,
                                    cacheHeight: 300,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.pets,
                                          size: 50,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              const SizedBox(width: 20),

                              // INFORMACIÓN DEL AVATAR
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      customName,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF2D3436),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      avatar['quote'] as String,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black.withAlpha(180),
                                        height: 1.4,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // BADGE EQUIPADO EN ESQUINA SUPERIOR DERECHA
                        if (isEquipped)
                          Positioned(
                            top: 15,
                            right: 15,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4CAF50),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'EQUIPADO',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF4CAF50),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
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

      // BARRA DE NAVEGACIÓN
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 0, noHighlight: true),
    );
  }
}