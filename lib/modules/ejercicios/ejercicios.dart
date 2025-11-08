import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/appbar.dart' as appbar_file;
import 'ayuda.dart';
import 'ejercicios_completos.dart';

class EjerciciosScreen extends StatefulWidget {
  const EjerciciosScreen({super.key});

  @override
  State<EjerciciosScreen> createState() => _EjerciciosScreenState();
}

class _EjerciciosScreenState extends State<EjerciciosScreen> {
  int currentExercise = 1;
  int totalExercises = 4;
  String userAnswer = '';
  TextEditingController answerController = TextEditingController();
  bool showMotivationalMessage = false;
  List<String> motivationalPhrases = [
    '¡Excelente! Sigamos adelante 💪',
    '¡Vas por buen camino! 🚀',
    '¡Sigue así, lo estás haciendo genial! 🌟',
    '¡Cada ejercicio te acerca a tu meta! 🎯',
    '¡Tu esfuerzo vale la pena! 💫',
    '¡Eres capaz de lograr lo que te propongas! 🔥'
  ];
  String currentMotivationalPhrase = '';

  // Variables para el cronómetro
  int remainingSeconds = 25 * 60; // 25 minutos en segundos
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    answerController.text = userAnswer;
    _selectRandomPhrase();
    _startTimer();
  }

  void _startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _selectRandomPhrase() {
    final random = DateTime.now().millisecondsSinceEpoch;
    final index = random % motivationalPhrases.length;
    setState(() {
      currentMotivationalPhrase = motivationalPhrases[index];
    });
  }

  @override
  void dispose() {
    answerController.dispose();
    countdownTimer?.cancel();
    super.dispose();
  }

  void _handleNoButton() {
    if (userAnswer.trim().isEmpty) {
      _showErrorDialog('Debes ingresar una respuesta antes de continuar');
      return;
    }

    setState(() {
      showMotivationalMessage = true;
      _selectRandomPhrase();
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showMotivationalMessage = false;
          if (currentExercise < totalExercises) {
            currentExercise++;
            answerController.clear();
            userAnswer = '';
          }
        });
      }
    });
  }

  void _handleNextButton() {
    if (userAnswer.trim().isEmpty) {
      _showErrorDialog('Debes ingresar una respuesta antes de continuar');
      return;
    }

    setState(() {
      if (currentExercise < totalExercises) {
        currentExercise++;
        answerController.clear();
        userAnswer = '';
      } else {
        _navigateToCompletedScreen();
      }
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
              SizedBox(width: 8),
              Text('Atención'),
            ],
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF42A5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Entendido',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToCompletedScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const EjerciciosCompletosScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // APPBAR
      appBar: appbar_file.AppBarComponents.buildAppBar(
        context,
        'SEMANA 1: Ecuaciones lineales',
      ),

      body: Column(
        children: [
          // BARRA DE PROGRESO + CRONÓMETRO (cronómetro más a la izquierda)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              children: [
                // Barra de progreso con corona
                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: FractionallySizedBox(
                              widthFactor: currentExercise / totalExercises,
                              child: Container(
                                height: 12,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFDD835),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '$currentExercise/$totalExercises',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.emoji_events,
                      color: Color(0xFFFDD835),
                      size: 32,
                    ),
                  ],
                ),

                // Espacio aumentado y cronómetro más a la izquierda
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft, // Alinea todo a la izquierda
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Alineación izquierda
                    mainAxisSize: MainAxisSize.min, // Ocupa solo el espacio necesario
                    children: [
                      const Text(
                        'Te quedan ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        _formatTime(remainingSeconds),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.alarm,
                        color: remainingSeconds < 300
                            ? Colors.red[400]
                            : Colors.orange[400],
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ESPACIO AUMENTADO entre cronómetro y card de ejercicio
          const SizedBox(height: 24),

          // CONTENIDO PRINCIPAL
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // CARD DEL EJERCICIO
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF90CAF9),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Encabezado ejercicio
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          decoration: const BoxDecoration(
                            color: Color(0xFF90CAF9),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14),
                              topRight: Radius.circular(14),
                            ),
                          ),
                          child: Text(
                            'Ejercicio Nº $currentExercise',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),

                        // Contenido ejercicio
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Resolver:',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Center(
                                child: Text(
                                  '6(3x+5)= 13(2x+5)+ -14',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color(0xFF90CAF9),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: TextField(
                                  controller: answerController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Pon el resultado aquí',
                                    hintStyle: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    setState(() {
                                      userAnswer = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // MENOS ESPACIO entre card y botón para subir los botones
                  const SizedBox(height: 8),

                  // BOTÓN SIGUIENTE
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _handleNextButton,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF65C438),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        currentExercise == totalExercises
                            ? 'Finalizar'
                            : 'Siguiente',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // MÁS ESPACIO antes de la sección de la llama para bajarla
                  const SizedBox(height: 16),

                  // SECCIÓN DE LA LLAMA (bajada con más espacio arriba)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Imagen de la llama bajada
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8), // Baja un poco más la llama
                        child: Image.asset(
                          'assets/images/llama.png',
                          width: 180,
                          height: 180,
                          filterQuality: FilterQuality.high,
                          isAntiAlias: true,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                color: Colors.orange[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.pets,
                                size: 90,
                                color: Colors.orange,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (showMotivationalMessage)
                              // MENSAJE MOTIVACIONAL
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4CAF50),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.celebration,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        currentMotivationalPhrase,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else if (currentExercise < totalExercises)
                              // CARD DE AYUDA + BOTONES
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 14),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF42A5F5),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Text(
                                      '¿Te doy una guía\npara avanzar?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        height: 1.3,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const GuiaSolucionScreen(),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF65C438),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 28, vertical: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          elevation: 0,
                                        ),
                                        child: const Text(
                                          'Sí',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      ElevatedButton(
                                        onPressed: _handleNoButton,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFFE00025),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 28, vertical: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          elevation: 0,
                                        ),
                                        child: const Text(
                                          'No',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            else
                              // ÚLTIMO EJERCICIO
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFA726),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        '¡Último ejercicio! Completa para ver tus resultados',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar:
          appbar_file.AppBarComponents.buildBottomNavBar(context, 1),
    );
  }
}