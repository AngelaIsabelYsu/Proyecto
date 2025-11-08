import 'package:flutter/material.dart';
import '../../widgets/appbar.dart' as appbar_file;

class PodioScreen extends StatefulWidget {
  final int puntajeUsuario;
  
  const PodioScreen({
    super.key,
    required this.puntajeUsuario,
  });

  @override
  State<PodioScreen> createState() => _PodioScreenState();
}

class _PodioScreenState extends State<PodioScreen> {
  late List<Map<String, dynamic>> _todosLosJugadores;
  
  @override
  void initState() {
    super.initState();
    _inicializarRanking();
  }
  
  void _inicializarRanking() {
    // Lista de jugadores con sus puntajes (simulación)
    _todosLosJugadores = [
      {'name': 'AJISDC', 'points': 400, 'isUser': false},
      {'name': 'AJISDC', 'points': 350, 'isUser': false},
      {'name': 'AJISDC', 'points': 300, 'isUser': false},
      {'name': 'JACNI SCNOW ANICWHW', 'points': 295, 'isUser': false},
      {'name': 'JACNI SCNOW ANICWHW', 'points': 290, 'isUser': false},
      {'name': 'JACNI SCNOW ANICWHW', 'points': 285, 'isUser': false},
      {'name': 'JACNI SCNOW ANICWHW', 'points': 280, 'isUser': false},
      {'name': 'JACNI SCNOW ANICWHW', 'points': 275, 'isUser': false},
    ];
    
    // Agregar el usuario con su puntaje
    _todosLosJugadores.add({
      'name': 'TÚ (Angela)',
      'points': widget.puntajeUsuario,
      'isUser': true,
    });
    
    // Ordenar por puntaje descendente
    _todosLosJugadores.sort((a, b) => (b['points'] as int).compareTo(a['points'] as int));
  }

  @override
  Widget build(BuildContext context) {
    // Jugadores del podio (top 3)
    final primerLugar = _todosLosJugadores[0];
    final segundoLugar = _todosLosJugadores.length > 1 ? _todosLosJugadores[1] : null;
    final tercerLugar = _todosLosJugadores.length > 2 ? _todosLosJugadores[2] : null;
    
    // Resto de jugadores (desde el 4to lugar)
    final restoJugadores = _todosLosJugadores.length > 3 
        ? _todosLosJugadores.sublist(3) 
        : <Map<String, dynamic>>[];

    return Scaffold(
      backgroundColor: Colors.white,
      
      // APPBAR CORREGIDO - usando AppBarComponents
      appBar: appbar_file.AppBarComponents.buildAppBar(
        context, 
        'SEMANA 1: Ecuaciones lineales'
      ),
      
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // BANDERINES DECORATIVOS
                  CustomPaint(
                    size: const Size(double.infinity, 80),
                    painter: BannerPainter(),
                  ),
                  
                  // PODIO
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        // TROFEO Y PUNTOS DEL PRIMERO
                        const Icon(
                          Icons.emoji_events,
                          color: Color(0xFFFFA726),
                          size: 80,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${primerLugar['points']}P',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // ESTRUCTURA DEL PODIO
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // TERCER LUGAR
                            if (tercerLugar != null)
                              Expanded(
                                child: _buildPodiumPlace(
                                  position: 3,
                                  name: tercerLugar['name'],
                                  points: tercerLugar['points'],
                                  color: const Color(0xFF66BB6A),
                                  height: 120,
                                  isUser: tercerLugar['isUser'] ?? false,
                                ),
                              ),
                            
                            const SizedBox(width: 8),
                            
                            // PRIMER LUGAR
                            Expanded(
                              child: _buildPodiumPlace(
                                position: 1,
                                name: primerLugar['name'],
                                points: primerLugar['points'],
                                color: const Color(0xFFEF5350),
                                height: 160,
                                isUser: primerLugar['isUser'] ?? false,
                                showNameAbove: true,
                              ),
                            ),
                            
                            const SizedBox(width: 8),
                            
                            // SEGUNDO LUGAR
                            if (segundoLugar != null)
                              Expanded(
                                child: _buildPodiumPlace(
                                  position: 2,
                                  name: segundoLugar['name'],
                                  points: segundoLugar['points'],
                                  color: const Color(0xFFFFA726),
                                  height: 140,
                                  isUser: segundoLugar['isUser'] ?? false,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // LISTA DE RANKINGS (del 4to lugar en adelante)
                  if (restoJugadores.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: restoJugadores.length,
                      itemBuilder: (context, index) {
                        final jugador = restoJugadores[index];
                        final posicion = index + 4;
                        final isUser = jugador['isUser'] ?? false;
                        
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: isUser 
                                ? const Color(0xFFFFEB3B)
                                : const Color(0xFF42A5F5),
                            borderRadius: BorderRadius.circular(25),
                            border: isUser 
                                ? Border.all(
                                    color: const Color(0xFFFFA726),
                                    width: 3,
                                  )
                                : null,
                          ),
                          child: Row(
                            children: [
                              Text(
                                '$posicion°',
                                style: TextStyle(
                                  color: isUser ? Colors.black87 : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  jugador['name'],
                                  style: TextStyle(
                                    color: isUser ? Colors.black87 : Colors.white,
                                    fontSize: 16,
                                    fontWeight: isUser ? FontWeight.bold : FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text(
                                '${jugador['points']}P',
                                style: TextStyle(
                                  color: isUser ? Colors.black87 : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (isUser) ...[
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.star,
                                  color: Color(0xFFFFA726),
                                  size: 24,
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      
      // BOTTOM NAVIGATION BAR CORREGIDO - índice 1 para Módulos
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 1),
    );
  }

  Widget _buildPodiumPlace({
    required int position,
    required String name,
    required int points,
    required Color color,
    required double height,
    required bool isUser,
    bool showNameAbove = false,
  }) {
    return Column(
      children: [
        if (position != 1) ...[
          Text(
            '${points}P',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isUser ? const Color(0xFFFFEB3B) : Colors.grey[300],
              shape: BoxShape.circle,
              border: isUser 
                  ? Border.all(color: const Color(0xFFFFA726), width: 3)
                  : null,
            ),
            child: Icon(
              isUser ? Icons.star : (position == 2 ? Icons.military_tech : Icons.person),
              color: isUser ? const Color(0xFFFFA726) : (position == 2 ? Colors.amber : Colors.pink),
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
        ],
        if (showNameAbove) ...[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: isUser ? const Color(0xFFFFEB3B) : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
              border: isUser 
                  ? Border.all(color: const Color(0xFFFFA726), width: 2)
                  : null,
            ),
            child: Text(
              name.length > 8 ? '${name.substring(0, 8)}...' : name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isUser ? FontWeight.bold : FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            border: isUser 
                ? Border.all(color: const Color(0xFFFFEB3B), width: 4)
                : null,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!showNameAbove && position != 1)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      name.length > 6 ? '${name.substring(0, 6)}...' : name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Text(
                  '$position',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: position == 1 ? 80 : (position == 2 ? 56 : 48),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// PAINTER PARA LOS BANDERINES
class BannerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    final linePaint = Paint()
      ..color = Colors.grey[800]!
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    
    canvas.drawLine(
      Offset(0, size.height * 0.3),
      Offset(size.width, size.height * 0.3),
      linePaint,
    );
    
    final colors = [
      Colors.orange,
      const Color(0xFF42A5F5),
      Colors.red,
      Colors.yellow,
      Colors.green,
      const Color(0xFF42A5F5),
      Colors.pink,
      Colors.orange,
      Colors.yellow,
      Colors.red,
      Colors.green,
      Colors.pink,
    ];
    
    const bannerWidth = 30.0;
    const bannerHeight = 45.0;
    final spacing = size.width / colors.length;
    
    for (int i = 0; i < colors.length; i++) {
      final x = i * spacing + spacing / 2 - bannerWidth / 2;
      final y = size.height * 0.3;
      
      paint.color = colors[i];
      
      final path = Path()
        ..moveTo(x, y)
        ..lineTo(x + bannerWidth, y)
        ..lineTo(x + bannerWidth, y + bannerHeight - 10)
        ..lineTo(x + bannerWidth / 2, y + bannerHeight)
        ..lineTo(x, y + bannerHeight - 10)
        ..close();
      
      canvas.drawPath(path, paint);
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}