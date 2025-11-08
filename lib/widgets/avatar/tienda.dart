import 'package:flutter/material.dart';
import '../../widgets/appbar.dart' as appbar_file;

class TiendaDelAvatar extends StatefulWidget {
  final String animalType; // 'hipopotamo', 'leon', 'conejo'
  final String animalImage;
  final String animalName;
  final Color backgroundColor;

  const TiendaDelAvatar({
    super.key,
    this.animalType = 'hipopotamo', // Valor por defecto
    this.animalImage = 'assets/images/ahipopotamo.png', // Valor por defecto
    this.animalName = 'Hipopótamo', // Valor por defecto
    this.backgroundColor = const Color(0xFFFFC1CC), // Valor por defecto
  });

  @override
  State<TiendaDelAvatar> createState() => _TiendaDelAvatarState();
}

class _TiendaDelAvatarState extends State<TiendaDelAvatar> {
  // Variable para guardar qué polo está seleccionado
  int _poloSeleccionado = 0; // 0 significa ninguno seleccionado

  // Lista de imágenes de avatar según el tipo de animal
  List<String> get _avatarImages {
    switch (widget.animalType) {
      case 'leon':
        return [
          'assets/images/aleon.png', // Polo 0 (ninguno)
          'assets/images/lcp1.png', // Polo 1
          'assets/images/lcp2.png', // Polo 2
          'assets/images/lcpo3.png', // Polo 3
          'assets/images/lcp4.png', // Polo 4
          'assets/images/lcp5.png', // Polo 5
          'assets/images/lcp6.png', // Polo 6
        ];
      case 'conejo':
        return [
          'assets/images/aconejo.png', // Polo 0 (ninguno)
          'assets/images/ccp1.png', // Polo 1
          'assets/images/ccp2.png', // Polo 2
          'assets/images/ccp3.png', // Polo 3
          'assets/images/ccp4.png', // Polo 4
          'assets/images/ccp5.png', // Polo 5
          'assets/images/ccp6.png', // Polo 6
        ];
      case 'hipopotamo':
      default:
        return [
          'assets/images/ahipopotamo.png', // Polo 0 (ninguno)
          'assets/images/hcp1.png', // Polo 1
          'assets/images/hcp2.png', // Polo 2
          'assets/images/hcp3.png', // Polo 3
          'assets/images/hcp4.png', // Polo 4
          'assets/images/hcp5.png', // Polo 5
          'assets/images/hcp6.png', // Polo 6
        ];
    }
  }

  // Precios de los polos según el animal
  Map<int, int> get _preciosPolos {
    switch (widget.animalType) {
      case 'leon':
        return {
          1: 850,
          2: 550,
          3: 700,
          4: 900,
          5: 750,
          6: 300,
        };
      case 'conejo':
        return {
          1: 780,
          2: 480,
          3: 630,
          4: 880,
          5: 680,
          6: 250,
        };
      case 'hipopotamo':
      default:
        return {
          1: 800,
          2: 500,
          3: 650,
          4: 820,
          5: 705,
          6: 205,
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR PERSONALIZADO
      appBar: appbar_file.AppBarComponents.buildAppBar(context, 'Tienda - ${widget.animalName}'),

      // BOTTOM NAVIGATION BAR PERSONALIZADO - SIN RESALTADO
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 0, noHighlight: true),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Avatar section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: Image.asset(
                      _avatarImages[_poloSeleccionado],
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                      isAntiAlias: true,
                      cacheWidth: 500,
                      cacheHeight: 500,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0x33FFFFFF),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.pets,
                                size: 60,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Polo $_poloSeleccionado',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            // Ropa section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Ropa',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.75,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildClothingItem('polo1.png', _preciosPolos[1]!, 1),
                      _buildClothingItem('polo2.png', _preciosPolos[2]!, 2),
                      _buildClothingItem('polo3.png', _preciosPolos[3]!, 3),
                      _buildClothingItem('polo4.png', _preciosPolos[4]!, 4),
                      _buildClothingItem('polo5.png', _preciosPolos[5]!, 5),
                      _buildClothingItem('polo6.png', _preciosPolos[6]!, 6),
                    ],
                  ),
                  
                  // Volver button
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB8E986),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Volver',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClothingItem(String imagePath, int price, int numeroPolo) {
    bool estaSeleccionado = _poloSeleccionado == numeroPolo;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _poloSeleccionado = numeroPolo;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: estaSeleccionado ? const Color(0xFFE8F5E8) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: estaSeleccionado ? const Color(0xFF4CAF50) : Colors.grey.shade300,
                  width: estaSeleccionado ? 2.5 : 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: estaSeleccionado 
                      ? const Color(0x4D4CAF50)
                      : const Color(0x28000000),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/$imagePath',
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                    cacheWidth: 250,
                    cacheHeight: 250,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.shopping_bag,
                              size: 40,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Polo $numeroPolo',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  if (estaSeleccionado)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                color: estaSeleccionado ? const Color(0xFF4CAF50) : const Color(0xFF42A5F5),
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                price.toString(),
                style: TextStyle(
                  color: estaSeleccionado ? const Color(0xFF4CAF50) : const Color(0xFF42A5F5),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (estaSeleccionado)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'En uso',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}