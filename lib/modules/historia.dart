import 'package:flutter/material.dart';
import 'ejercicios/total_de_ejercicios.dart'; 
import '../widgets/appbar.dart' as appbar_file;

class HistoriaScreen extends StatefulWidget {
  final String numeroSemana;
  final String tituloSemana;
  final String descripcionSemana;
  final Color colorSemana;
  final double progresoSemana;
  final int totalSemana;
  final int completadosSemana;
  final String moduleType; 
  final int temaIndex;     
  final String temaTitle;  

  const HistoriaScreen({
    super.key,
    required this.numeroSemana,
    required this.tituloSemana,
    required this.descripcionSemana,
    required this.colorSemana,
    required this.progresoSemana,
    required this.totalSemana,
    required this.completadosSemana,
    required this.moduleType,
    required this.temaIndex,
    required this.temaTitle,
  });

  @override
  State<HistoriaScreen> createState() => _HistoriaScreenState();
}

class _HistoriaScreenState extends State<HistoriaScreen> {
  final List<Map<String, dynamic>> _hitosCamino = [
    {
      'descripcion': 'Los egipcios también aplicaban álgebra, usando un método llamado falsa posición para encontrar valores desconocidos.',
      'imagen': 'assets/images/egiph.png',
      'posicion': Offset(0.05, 0.08),
      'color': Color(0xB3FFFFFF),
      'lado': 'izquierda', 
    },
    {
      'descripcion': 'En China, el libro "Los Nueve Capítulos" resolvía sistemas de ecuaciones con algo parecido a una matriz.',
      'imagen': 'assets/images/chinah.png',
      'posicion': Offset(0.05, 0.38),
      'color': Color(0xB3FFFFFF),
      'lado': 'derecha', 
    },
    {
      'descripcion': 'En Europa, Descartes introdujo el uso de letras como x y y, y con él nació el álgebra moderna.',
      'imagen': 'assets/images/ecuacionh.png',
      'posicion': Offset(0.05, 0.68),
      'color': Color(0xB3FFFFFF),
      'lado': 'izquierda',
    },
  ];

  void _onContinueButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SemanaEjerciciosScreen( 
          weekTitle: 'Semana ${widget.numeroSemana}: ${widget.tituloSemana}',
          weekNumber: int.tryParse(widget.numeroSemana) ?? 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: appbar_file.AppBarComponents.buildBackAppBar(
        context, 
        'SEM ${widget.numeroSemana}: ${widget.tituloSemana}'
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(right: 80),
                            decoration: BoxDecoration(
                              color: const Color(0xFF9DD9FF),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '¿Sabías que... las ecuaciones',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2,
                                    ),
                                  ),
                                  Text(
                                    'lineales existen desde hace',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2,
                                    ),
                                  ),
                                  Text(
                                    'más de 4,000 años?',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 6),

                        Expanded(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(right: 80),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF9DD9FF),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(25),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Los babilonios ya resolvían problemas parecidos a ',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'ax + b = c ',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '¡usando tablillas de arcilla!',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    Positioned(
                      right: -10,
                      top: 0,
                      bottom: 0,
                      child: SizedBox(
                        width: 160,
                        height: 160,
                        child: Image.asset(
                          'assets/images/llamah.png',
                          width: 160,
                          height: 160,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(76),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.emoji_emotions,
                                color: Colors.white,
                                size: 60,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 450,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/caminoh.png',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue.shade100,
                              Colors.green.shade100,
                              Colors.yellow.shade100,
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.landscape,
                            size: 60,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),

                  ..._hitosCamino.map((hito) {
                    final posicion = hito['posicion'] as Offset;
                    final lado = hito['lado'] as String;
                    return _buildHitoConCard(
                      hito['descripcion'] as String,
                      hito['imagen'] as String,
                      Offset(
                        posicion.dx * screenWidth,
                        posicion.dy * 450,
                      ),
                      hito['color'] as Color,
                      lado: lado,
                      screenWidth: screenWidth,
                    );
                  }),

                  Positioned(
                    right: 15,
                    bottom: 20,
                    child: GestureDetector(
                      onTap: _onContinueButtonPressed,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        child: const Text(
                          'Continuar',
                          style: TextStyle(
                            color: Color(0xFF0664B8),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF0664B8),
                            decorationThickness: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 1),
    );
  }

  Widget _buildHitoConCard(
    String descripcion, 
    String imagen, 
    Offset posicion, 
    Color color, {
    required String lado,
    required double screenWidth,
  }) {
    return Positioned(
      left: lado == 'izquierda' ? posicion.dx : null,
      right: lado == 'derecha' ? screenWidth * 0.05 : null,
      top: posicion.dy,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          textDirection: lado == 'derecha' ? TextDirection.rtl : TextDirection.ltr,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(80),
                    blurRadius: 6,
                    offset: const Offset(2, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagen,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade200,
                      ),
                      child: const Icon(
                        Icons.history_edu,
                        color: Colors.grey,
                        size: 28,
                      ),
                    );
                  },
                ),
              ),
            ),
            
            const SizedBox(width: 10),
            
            Flexible(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 190,
                ),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(70),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withAlpha(80),
                    width: 0.8,
                  ),
                ),
                child: Text(
                  descripcion,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                  textAlign: lado == 'derecha' ? TextAlign.right : TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}