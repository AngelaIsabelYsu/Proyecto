import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/appbar.dart' as appbar_file;
import '../../services/gemas_service.dart';

class TiendaDelAvatar extends StatefulWidget {
  final String animalType;
  final String animalImage;
  final String animalName;
  final Color backgroundColor;

  const TiendaDelAvatar({
    super.key,
    this.animalType = 'hipopotamo',
    this.animalImage = 'assets/images/ahipopotamo.png',
    this.animalName = 'Hipopótamo',
    this.backgroundColor = const Color(0xFFFFC1CC),
  });

  @override
  State<TiendaDelAvatar> createState() => _TiendaDelAvatarState();
}

class _TiendaDelAvatarState extends State<TiendaDelAvatar> {
  int _poloSeleccionado = 0;
  List<int> _polosComprados = [0];

  @override
  void initState() {
    super.initState();
    _polosComprados = [0];
    _poloSeleccionado = 0;
    _cargarDatosGuardados();
  }

  Future<void> _cargarDatosGuardados() async {
    final prefs = await SharedPreferences.getInstance();
    final poloSeleccionado = prefs.getInt('${widget.animalType}_poloSeleccionado') ?? 0;
    final polosCompradosString = prefs.getString('${widget.animalType}_polosComprados');
    
    List<int> polosComprados;
    if (polosCompradosString == null) {
      polosComprados = [0];
    } else {
      polosComprados = polosCompradosString.split(',').map((e) => int.tryParse(e) ?? 0).toList();
    }
    
    setState(() {
      _poloSeleccionado = poloSeleccionado;
      _polosComprados = polosComprados;
    });
  }

  Future<void> _guardarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${widget.animalType}_poloSeleccionado', _poloSeleccionado);
    await prefs.setString('${widget.animalType}_polosComprados', _polosComprados.join(','));
  }

  List<String> get _avatarImages {
    switch (widget.animalType) {
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

  List<String> get _poloNames {
    // index 0 = original (no polo), 1..6 correspond to polos
    switch (widget.animalType) {
      case 'leon':
        return [
          'Original',
          'Polo Safari',
          'Polo Rayado',
          'Polo Real',
          'Polo Tropical',
          'Polo Dorado',
          'Polo Noche',
        ];
      case 'conejo':
        return [
          'Original',
          'Polo Primavera',
          'Polo Lazo',
          'Polo Picnic',
          'Polo Floral',
          'Polo Pastel',
          'Polo Neon',
        ];
      case 'hipopotamo':
      default:
        return [
          'Original',
          'Polo Safari',
          'Polo Azul',
          'Polo Marino',
          'Polo Tropical',
          'Polo Geométrico',
          'Polo Neón',
        ];
    }
  }

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
          1: 850,
          2: 550,
          3: 700,
          4: 900,
          5: 750,
          6: 300,
        };
      case 'hipopotamo':
      default:
        return {
          1: 150,
          2: 550,
          3: 700,
          4: 900,
          5: 750,
          6: 300,
        };
    }
  }

  void _mostrarDialogoConfirmacion(int numeroPolo, int precio, GemasService gemasService) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final nombrePolo = _poloNames[numeroPolo];
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Confirmar compra',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF42A5F5),
            ),
          ),
          content: Text(
            '¿Estás seguro de que quieres comprar "$nombrePolo" (Polo $numeroPolo) por $precio gemas?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
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
                _comprarPolo(numeroPolo, precio, gemasService);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Comprar',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  void _comprarPolo(int numeroPolo, int precio, GemasService gemasService) {
    if (gemasService.totalGemas >= precio) {
      gemasService.restarGemas(precio);
      setState(() {
        _polosComprados.add(numeroPolo);
        _poloSeleccionado = numeroPolo;
      });
      _guardarDatos();
      
      final nombrePolo = _poloNames[numeroPolo];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡$nombrePolo comprado por $precio gemas!'),
          backgroundColor: const Color(0xFF4CAF50),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No tienes suficientes gemas'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _seleccionarPolo(int numeroPolo) {
    setState(() {
      if (_poloSeleccionado == numeroPolo) {
        _poloSeleccionado = 0;
      } else {
        _poloSeleccionado = numeroPolo;
      }
    });
    _guardarDatos();
  }

  @override
  Widget build(BuildContext context) {
    final gemasService = Provider.of<GemasService>(context);

    return Scaffold(
      appBar: AppBar(
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
        title: const Text(
          'Tienda',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 0, noHighlight: true),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0x99FFFFFF),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF000000).withAlpha(13),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Tus gemas',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '💎',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          gemasService.totalGemas.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 160, 
                    height: 220, 
                    child: Image.asset(
                      _avatarImages[_poloSeleccionado],
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                      isAntiAlias: true,
                      cacheWidth: 320, 
                      cacheHeight: 440, 
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0x33FFFFFF),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.pets,
                                size: 55,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                  _poloSeleccionado == 0
                                    ? 'Avatar original'
                                    : _poloNames[_poloSeleccionado],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            
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
                      _buildClothingItem('polo1.png', _preciosPolos[1]!, 1, gemasService),
                      _buildClothingItem('polo2.png', _preciosPolos[2]!, 2, gemasService),
                      _buildClothingItem('polo3.png', _preciosPolos[3]!, 3, gemasService),
                      _buildClothingItem('polo4.png', _preciosPolos[4]!, 4, gemasService),
                      _buildClothingItem('polo5.png', _preciosPolos[5]!, 5, gemasService),
                      _buildClothingItem('polo6.png', _preciosPolos[6]!, 6, gemasService),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClothingItem(String imagePath, int price, int numeroPolo, GemasService gemasService) {
    bool estaComprado = _polosComprados.contains(numeroPolo);
    bool estaSeleccionado = _poloSeleccionado == numeroPolo;
    bool puedeComprar = gemasService.totalGemas >= price;
    
    return GestureDetector(
      onTap: () {
        if (estaComprado) {
          _seleccionarPolo(numeroPolo);
        } else if (puedeComprar) {
          _mostrarDialogoConfirmacion(numeroPolo, price, gemasService);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: estaSeleccionado ? const Color(0xFFE8F5E8) : 
                       estaComprado ? Colors.white : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: estaSeleccionado ? const Color(0xFF4CAF50) : 
                         estaComprado ? Colors.grey.shade300 : Colors.grey.shade400,
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
                    cacheWidth: 180,
                    cacheHeight: 180,
                    color: estaComprado ? null : Colors.grey,
                    colorBlendMode: estaComprado ? BlendMode.srcIn : BlendMode.saturation,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_bag,
                              size: 38,
                              color: estaComprado ? Colors.grey : Colors.grey.shade400,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _poloNames[numeroPolo],
                              style: TextStyle(
                                fontSize: 10,
                                color: estaComprado ? Colors.grey : Colors.grey.shade400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  if (!estaComprado)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF000000).withAlpha(178),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                  if (estaSeleccionado && estaComprado)
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
          Text(
            _poloNames[numeroPolo],
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: estaComprado ? (estaSeleccionado ? const Color(0xFF4CAF50) : const Color(0xFF42A5F5)) : Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '💎',
                style: TextStyle(
                  fontSize: 16,
                  color: estaComprado ? 
                    (estaSeleccionado ? const Color(0xFF4CAF50) : const Color(0xFF42A5F5)) : 
                    Colors.grey,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                price.toString(),
                style: TextStyle(
                  color: estaComprado ? 
                    (estaSeleccionado ? const Color(0xFF4CAF50) : const Color(0xFF42A5F5)) : 
                    Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (estaSeleccionado && estaComprado)
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
          if (!estaComprado && !puedeComprar)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Gemas insuficientes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          if (estaComprado && !estaSeleccionado)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF42A5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Usar',
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