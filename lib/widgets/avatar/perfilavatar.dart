import 'package:flutter/material.dart';
import 'tienda.dart';
import '../../widgets/appbar.dart' as appbar_file;

class AvatarDetailScreen extends StatefulWidget {
  final String name;
  final String authorName;
  final String imagePath;
  final Color backgroundColor;
  final String description;
  final bool isEquipped;
  final Function(String)? onNameChanged;
  final Function(bool)? onEquippedChanged;

  const AvatarDetailScreen({
    super.key,
    required this.name,
    required this.authorName,
    required this.imagePath,
    required this.backgroundColor,
    required this.description,
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

  @override
  void initState() {
    super.initState();
    _isEquipped = widget.isEquipped;
    _currentAuthorName = widget.authorName;
  }

  void _toggleEquipped() {
    setState(() {
      _isEquipped = !_isEquipped;
    });

    if (widget.onEquippedChanged != null) {
      widget.onEquippedChanged!(_isEquipped);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isEquipped 
              ? 'Avatar equipado exitosamente' 
              : 'Avatar desequipado',
        ),
        backgroundColor: _isEquipped 
            ? const Color(0xFF4CAF50) 
            : Colors.grey[600],
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _navigateToStore() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TiendaDelAvatar(),
      ),
    );
  }

  void _changeAuthorName(String newName) {
    setState(() {
      _currentAuthorName = newName;
    });
    
    if (widget.onNameChanged != null) {
      widget.onNameChanged!(newName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      // APPBAR PERSONALIZADO - SIN RESALTADO
      appBar: appbar_file.AppBarComponents.buildAppBar(context, 'Avatar'),

      // BOTTOM NAVIGATION BAR PERSONALIZADO - SIN RESALTADO
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 0, noHighlight: true),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            AvatarSection(
              imagePath: widget.imagePath,
              backgroundColor: widget.backgroundColor,
            ),
            
            const SizedBox(height: 20),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  AvatarNameSection(
                    authorName: _currentAuthorName,
                    onNameChanged: _changeAuthorName,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  ChangeNameButton(
                    onNameChanged: _changeAuthorName,
                    currentName: _currentAuthorName,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  DescriptionSection(
                    description: widget.description,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  Row(
                    children: [
                      Expanded(
                        child: StoreButton(
                          onTap: _navigateToStore,
                        ),
                      ),
                      
                      const SizedBox(width: 12),
                      
                      Expanded(
                        child: EquipButton(
                          isEquipped: _isEquipped,
                          onTap: _toggleEquipped,
                        ),
                      ),
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
}

class AvatarSection extends StatelessWidget {
  final String imagePath;
  final Color backgroundColor;

  const AvatarSection({
    super.key,
    required this.imagePath,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 260,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(179),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'L.I',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 8),
              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.pets,
                        size: 100,
                        color: Colors.white,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
            style: const TextStyle(
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
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.emoji_events,
                color: Color(0xFFD4AF37),
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.star,
                color: Color(0xFFFDD835),
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit, color: Colors.grey[600], size: 20),
            const SizedBox(width: 8),
            Text(
              'Cambiar de nombre',
              style: TextStyle(
                fontSize: 15,
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
        title: const Text(
          'Cambiar nombre del avatar',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ingresa el nuevo nombre para tu avatar:',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Nuevo nombre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              style: const TextStyle(fontSize: 16),
              maxLength: 20,
              textCapitalization: TextCapitalization.words,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
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
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Nombre cambiado a: $newName'),
                    backgroundColor: const Color(0xFF4CAF50),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor ingresa un nombre válido'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0984E3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Text(
        description,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[800],
          height: 1.5,
        ),
        textAlign: TextAlign.justify,
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
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF74B9FF),
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.checkroom,
            color: Color(0xFF0984E3),
            size: 28,
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
                  const Color(0xFFFDD835),
                  const Color(0xFFFBC02D),
                ]
              : [
                  const Color(0xFF4CAF50),
                  const Color(0xFF8BC34A),
                ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isEquipped
                ? Color(0xFFFDD835).withAlpha(77)
                : Color(0xFF4CAF50).withAlpha(77),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isEquipped ? 'Usando' : 'Equipar',
                  style: const TextStyle(
                    fontSize: 16,
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