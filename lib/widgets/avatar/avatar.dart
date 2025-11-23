import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/appbar.dart' as appbar_file;
import 'perfilavatar.dart'; 

class AvatarScreen extends StatefulWidget {
  const AvatarScreen({super.key});

  @override
  State<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  List<Map<String, dynamic>> _avatars = [];
  final Map<String, int> _polosSeleccionados = {};
  final Map<String, bool> _avatarsEquipados = {};

  @override
  void initState() {
    super.initState();
    _inicializarAvatares();
    _cargarDatos();
  }

  void _inicializarAvatares() {
    _avatars = [
      {
        'image': 'assets/images/ahipopotamo.png',
        'quote': 'La lógica fluye mejor cuando respiras hondo... como yo en la corriente.',
        'author': 'IGNIX',
        'name': 'Hipopótamo',
        'color': Color(0xFFFFC1CC),
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
        'color': Color(0xFFFFF4CC),
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
        'color': Color(0xFFD4F4F4),
        'description': 'Brinca de sumas a ecuaciones como si fueran charcos. Aunque a veces se equivoca, nunca se rinde. Él cree que los errores son saltos que te llevan más alto. Su energía contagiosa motiva a aprender más!',
        'isEquipped': false,
        'customName': 'DROP!',
        'animalType': 'conejo',
      },
    ];
  }

  Future<void> _cargarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    
    final nuevosPolosSeleccionados = <String, int>{};
    final nuevosAvatares = List<Map<String, dynamic>>.from(_avatars);
    final nuevosAvataresEquipados = <String, bool>{};
    
    for (var i = 0; i < nuevosAvatares.length; i++) {
      final animalType = nuevosAvatares[i]['animalType'] as String;
      final poloSeleccionado = prefs.getInt('${animalType}_poloSeleccionado') ?? 0;
      nuevosPolosSeleccionados[animalType] = poloSeleccionado;
      
      final nombreGuardado = prefs.getString('${animalType}_customName');
      if (nombreGuardado != null) {
        nuevosAvatares[i]['customName'] = nombreGuardado;
      }
      
      final avatarEquipado = prefs.getBool('${animalType}_equipado') ?? false;
      nuevosAvataresEquipados[animalType] = avatarEquipado;
      nuevosAvatares[i]['isEquipped'] = avatarEquipado;
    }
    
    if (mounted) {
      setState(() {
        _polosSeleccionados.clear();
        _polosSeleccionados.addAll(nuevosPolosSeleccionados);
        _avatarsEquipados.clear();
        _avatarsEquipados.addAll(nuevosAvataresEquipados);
        _avatars = nuevosAvatares;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cargarDatos();
  }

  List<String> getAvatarImages(String animalType) {
    switch (animalType) {
      case 'leon':
        return [
          'assets/images/aleon.png',
          'assets/images/lcp1.png',
          'assets/images/lcp2.png',
          'assets/images/lcp3.png',
          'assets/images/lcp4.png',
          'assets/images/lcp5.png',
          'assets/images/lcp6.png',
        ];
      case 'conejo':
        return [
          'assets/images/aconejo.png',
          'assets/images/ccp1.png',
          'assets/images/ccp2.png',
          'assets/images/ccp3.png',
          'assets/images/ccp4.png',
          'assets/images/ccp5.png',
          'assets/images/ccp6.png',
        ];
      case 'hipopotamo':
      default:
        return [
          'assets/images/ahipopotamo.png',
          'assets/images/hcp1.png',
          'assets/images/hcp2.png',
          'assets/images/hcp3.png',
          'assets/images/hcp4.png',
          'assets/images/hcp5.png',
          'assets/images/hcp6.png',
        ];
    }
  }

  void _updateAvatarName(int index, String newName) async {
    final prefs = await SharedPreferences.getInstance();
    final animalType = _avatars[index]['animalType'] as String;
    await prefs.setString('${animalType}_customName', newName);
    
    setState(() {
      _avatars[index]['customName'] = newName;
    });
  }

  void _updateAvatarEquipped(int index, bool isEquipped) async {
    final prefs = await SharedPreferences.getInstance();
    final animalType = _avatars[index]['animalType'] as String;
    
    if (isEquipped) {
      for (var i = 0; i < _avatars.length; i++) {
        final currentAnimalType = _avatars[i]['animalType'] as String;
        await prefs.setBool('${currentAnimalType}_equipado', false);
      }
    }
    
    await prefs.setBool('${animalType}_equipado', isEquipped);
    
    setState(() {
      for (var i = 0; i < _avatars.length; i++) {
        _avatars[i]['isEquipped'] = false;
      }
      _avatars[index]['isEquipped'] = isEquipped;
      _avatarsEquipados[animalType] = isEquipped;
    });
  }

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
            _updateAvatarName(index, newName);
          },
          onEquippedChanged: (isEquipped) {
            _updateAvatarEquipped(index, isEquipped);
          },
        ),
      ),
    ).then((_) {
      _cargarDatos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_file.AppBarComponents.buildAppBar(context, 'Avatar', currentScreen: 'avatar'),
      drawer: appbar_file.AppBarComponents.buildMenuDrawer(context, currentScreen: 'avatar'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              itemCount: _avatars.length,
              itemBuilder: (context, index) {
                final avatar = _avatars[index];
                final customName = avatar['customName'] as String;
                final isEquipped = avatar['isEquipped'] as bool;
                final animalType = avatar['animalType'] as String;
                final poloSeleccionado = _polosSeleccionados[animalType] ?? 0;
                final avatarImages = getAvatarImages(animalType);
                final currentImage = avatarImages[poloSeleccionado];
                
                return GestureDetector(
                  onTap: () {
                    _navigateToAvatarDetail(index, avatar);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: avatar['color'] as Color,
                      borderRadius: BorderRadius.circular(25),
                      border: isEquipped
                          ? Border.all(
                              color: Color(0xFF4CAF50),
                              width: 3,
                            )
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF000000).withAlpha(51),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                        if (isEquipped)
                          BoxShadow(
                            color: Color(0xFF4CAF50).withAlpha(102),
                            blurRadius: 20,
                            offset: Offset(0, 0),
                          ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(25),
                          child: Row(
                            children: [
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
                                    currentImage,
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.high,
                                    isAntiAlias: true,
                                    cacheWidth: 240,
                                    cacheHeight: 300,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        child: Icon(
                                          Icons.pets,
                                          size: 50,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      customName,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF2D3436),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      avatar['quote'] as String,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF000000).withAlpha(180),
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
                        if (isEquipped)
                          Positioned(
                            top: 15,
                            right: 15,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4CAF50),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'EQUIPADO',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4CAF50),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
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
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 0, noHighlight: true),
    );
  }
}