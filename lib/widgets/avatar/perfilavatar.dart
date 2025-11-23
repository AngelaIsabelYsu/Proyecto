import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tienda.dart';
import '../../widgets/appbar.dart' as appbar_file;

class AvatarDetailScreen extends StatefulWidget {
  final String name;
  final String authorName;
  final String imagePath;
  final Color backgroundColor;
  final String description;
  final bool isEquipped;
  final String animalType; 
  final Function(String)? onNameChanged;
  final Function(bool)? onEquippedChanged;

  const AvatarDetailScreen({
    super.key,
    required this.name,
    required this.authorName,
    required this.imagePath,
    required this.backgroundColor,
    required this.description,
    required this.animalType, 
    this.isEquipped = false,
    this.onNameChanged,
    this.onEquippedChanged,
  });

  @override
  State<AvatarDetailScreen> createState() => _AvatarDetailScreenState();
}

class _AvatarDetailScreenState extends State<AvatarDetailScreen> {
  late bool _isEquipped;
  late String _currentAuthorName;
  int _poloSeleccionado = 0;

  @override
  void initState() {
    super.initState();
    _isEquipped = false;
    _currentAuthorName = widget.authorName;
    _cargarDatosRapido();
  }

  Future<void> _cargarDatosRapido() async {
    final prefs = await SharedPreferences.getInstance();
    final poloSeleccionado = prefs.getInt('${widget.animalType}_poloSeleccionado') ?? 0;
    final nombreGuardado = prefs.getString('${widget.animalType}_customName');
    final avatarEquipado = prefs.getBool('${widget.animalType}_equipado') ?? false;
    
    if (mounted) {
      setState(() {
        _poloSeleccionado = poloSeleccionado;
        if (nombreGuardado != null) {
          _currentAuthorName = nombreGuardado;
        } else {
          _currentAuthorName = widget.authorName;
        }
        _isEquipped = avatarEquipado;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cargarDatosRapido();
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

  void _toggleEquipped() async {
    final prefs = await SharedPreferences.getInstance();
    final nuevaEquipacion = !_isEquipped;
    
    if (nuevaEquipacion) {
      for (final avatar in ['leon', 'conejo', 'hipopotamo']) {
        await prefs.setBool('${avatar}_equipado', false);
      }
    }
    
    await prefs.setBool('${widget.animalType}_equipado', nuevaEquipacion);
    
    if (mounted) {
      setState(() {
        _isEquipped = nuevaEquipacion;
      });
    }

    widget.onEquippedChanged?.call(nuevaEquipacion);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            nuevaEquipacion 
                ? 'Avatar equipado exitosamente' 
                : 'Avatar desequipado',
          ),
          backgroundColor: nuevaEquipacion 
              ? Color(0xFF4CAF50) 
              : Colors.grey[600],
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _navigateToStore() {
    String animalName;
    Color storeBackgroundColor;

    switch (widget.animalType) {
      case 'leon':
        animalName = 'León';
        storeBackgroundColor = Color(0xFFFFE5B4);
        break;
      case 'conejo':
        animalName = 'Conejo';
        storeBackgroundColor = Color(0xFFD4F4F4);
        break;
      case 'hipopotamo':
      default:
        animalName = 'Hipopótamo';
        storeBackgroundColor = Color(0xFFFFC1CC);
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TiendaDelAvatar(
          animalType: widget.animalType,
          animalName: animalName,
          backgroundColor: storeBackgroundColor,
        ),
      ),
    ).then((_) {
      _cargarDatosRapido();
    });
  }

  void _changeAuthorName(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('${widget.animalType}_customName', newName);
    
    if (mounted) {
      setState(() {
        _currentAuthorName = newName;
      });
    }
    
    widget.onNameChanged?.call(newName);
  }

  void _shareAvatar() {
    Share.share(
      '¡Mira mi avatar $_currentAuthorName! 🎮✨',
      subject: 'Mi Avatar',
    );
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Compartiendo avatar...'),
          backgroundColor: Color(0xFF0984E3),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
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
          'Avatar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 0, noHighlight: true),
      
      body: Column(
        children: [
          AvatarSection(
            imagePath: _avatarImages[_poloSeleccionado],
            backgroundColor: widget.backgroundColor,
            onShare: _shareAvatar,
          ),
          
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvatarNameSection(
                    authorName: _currentAuthorName,
                    onNameChanged: _changeAuthorName,
                  ),
                  
                  SizedBox(height: 16),
                  
                  ChangeNameButton(
                    onNameChanged: _changeAuthorName,
                    currentName: _currentAuthorName,
                  ),
                  
                  SizedBox(height: 16),
                  
                  Expanded(
                    child: DescriptionSection(
                      description: widget.description,
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  Row(
                    children: [
                      Expanded(
                        child: StoreButton(
                          onTap: _navigateToStore,
                        ),
                      ),
                      
                      SizedBox(width: 15),
                      
                      Expanded(
                        child: EquipButton(
                          isEquipped: _isEquipped,
                          onTap: _toggleEquipped,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AvatarSection extends StatelessWidget {
  final String imagePath;
  final Color backgroundColor;
  final VoidCallback onShare;

  const AvatarSection({
    super.key,
    required this.imagePath,
    required this.backgroundColor,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 240,
              height: 240,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
                isAntiAlias: true,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.pets,
                    size: 100,
                    color: Colors.white,
                  );
                },
              ),
            ),
          ),
          
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 20,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onShare,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF).withAlpha(178),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF000000).withAlpha(25),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.share,
                    size: 22,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AvatarNameSection extends StatelessWidget {
  final String authorName;
  final Function(String)? onNameChanged;

  const AvatarNameSection({
    super.key,
    required this.authorName,
    this.onNameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            authorName.toUpperCase(),
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.black,
              letterSpacing: 1,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.emoji_events,
                color: Color(0xFFD4AF37),
                size: 24,
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.star,
                color: Color(0xFFFDD835),
                size: 24,
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.diamond,
                color: Color(0xFF74B9FF),
                size: 24,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ChangeNameButton extends StatelessWidget {
  final Function(String) onNameChanged;
  final String currentName;

  const ChangeNameButton({
    super.key,
    required this.onNameChanged,
    required this.currentName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showChangeNameDialog(context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit, color: Colors.grey[600], size: 20),
            SizedBox(width: 8),
            Text(
              'Cambiar de nombre',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangeNameDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    controller.text = currentName;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Cambiar nombre del avatar',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ingresa el nuevo nombre para tu avatar:',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 12),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Nuevo nombre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              style: TextStyle(fontSize: 16),
              maxLength: 20,
              textCapitalization: TextCapitalization.words,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                onNameChanged(newName);
                Navigator.pop(context);
                
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Nombre cambiado a: $newName'),
                      backgroundColor: Color(0xFF4CAF50),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor ingresa un nombre válido'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0984E3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Guardar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class DescriptionSection extends StatelessWidget {
  final String description;

  const DescriptionSection({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFF0984E3),
          width: 2,
        ),
      ),
      child: SingleChildScrollView(
        child: Text(
          description,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[800],
            height: 1.5,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}

class StoreButton extends StatelessWidget {
  final VoidCallback onTap;

  const StoreButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color(0xFFF44336),
              width: 2,
            ),
          ),
          child: Icon(
            Icons.checkroom,
            color: Color(0xFFF44336),
            size: 30,
          ),
        ),
      ),
    );
  }
}

class EquipButton extends StatelessWidget {
  final bool isEquipped;
  final VoidCallback onTap;

  const EquipButton({
    super.key,
    required this.isEquipped,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isEquipped
              ? [
                  Color(0xFFFDD835),
                  Color(0xFFFBC02D),
                ]
              : [
                  Color(0xFF4CAF50),
                  Color(0xFF8BC34A),
                ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isEquipped
                ? Color(0xFFFDD835).withAlpha(76)
                : Color(0xFF4CAF50).withAlpha(76),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isEquipped ? 'Usando' : 'Equipar',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}