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

  int remainingSeconds = 25 * 60;
  Timer? countdownTimer;
  
  int totalGemas = 0;
  List<bool> usoGuiaPorEjercicio = [false, false, false, false];

  final List<Map<String, dynamic>> _ejercicios = [
    {
      'ecuacion': '2x + 5 = 13',
      'respuesta': '4'
    },
    {
      'ecuacion': '3(x - 4) = 15',
      'respuesta': '9'
    },
    {
      'ecuacion': '5x - 7 = 3x + 9',
      'respuesta': '8'
    },
    {
      'ecuacion': '4(2x + 1) = 3(x - 2)',
      'respuesta': '-2'
    },
    {
      'ecuacion': 'x/3 + 2 = 5',
      'respuesta': '9'
    },
    {
      'ecuacion': '2(x + 3) - 4 = 3(x - 1)',
      'respuesta': '5'
    },
    {
      'ecuacion': '7 - 2x = 3x + 2',
      'respuesta': '1'
    },
    {
      'ecuacion': '3x/2 - 1 = x + 4',
      'respuesta': '10'
    },
    {
      'ecuacion': '2(3x - 1) = 4(x + 2)',
      'respuesta': '5'
    },
    {
      'ecuacion': '5 - x = 2x - 7',
      'respuesta': '4'
    },
    {
      'ecuacion': 'x + 8 = 3x - 4',
      'respuesta': '6'
    },
    {
      'ecuacion': '4x - 9 = 2x + 3',
      'respuesta': '6'
    },
    {
      'ecuacion': '3(x + 2) = 2(x + 5)',
      'respuesta': '4'
    },
    {
      'ecuacion': '2x/5 + 1 = 3',
      'respuesta': '5'
    },
    {
      'ecuacion': '6 - 2x = x - 9',
      'respuesta': '5'
    }
  ];

  List<Map<String, dynamic>> _ejerciciosSeleccionados = [];

  @override
  void initState() {
    super.initState();
    _seleccionarEjerciciosAleatorios();
    answerController.text = userAnswer;
    _selectRandomPhrase();
    _startTimer();
  }

  void _seleccionarEjerciciosAleatorios() {
    _ejerciciosSeleccionados = [];
    List<Map<String, dynamic>> ejerciciosDisponibles = List.from(_ejercicios);
    
    for (int i = 0; i < totalExercises; i++) {
      if (ejerciciosDisponibles.isNotEmpty) {
        final randomIndex = DateTime.now().millisecondsSinceEpoch % ejerciciosDisponibles.length;
        _ejerciciosSeleccionados.add(ejerciciosDisponibles[randomIndex]);
        ejerciciosDisponibles.removeAt(randomIndex);
      }
    }
  }

  String get _ecuacionActual {
    if (_ejerciciosSeleccionados.isNotEmpty && currentExercise <= _ejerciciosSeleccionados.length) {
      return _ejerciciosSeleccionados[currentExercise - 1]['ecuacion'];
    }
    return '2x + 5 = 13';
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
    if (currentExercise <= totalExercises) {
      usoGuiaPorEjercicio[currentExercise - 1] = false;
    }
    
    setState(() {
      showMotivationalMessage = true;
      _selectRandomPhrase();
    });
  }

  void _handleSiButton() {
    _showGuiaConfirmationDialog();
  }

  void _showGuiaConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 32,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                const Text(
                  '¿Usar guía?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                const Text(
                  'Al usar la guía se te descontarán gemas de la recompensa final.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: 12),
                    
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (currentExercise <= totalExercises) {
                            usoGuiaPorEjercicio[currentExercise - 1] = true;
                          }
                          
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GuiaSolucionScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF65C438),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Usar guía',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleNextButton() {
    if (userAnswer.trim().isEmpty) {
      _showErrorDialog('Debes ingresar una respuesta antes de continuar');
      return;
    }

    setState(() {
      showMotivationalMessage = false;
      if (currentExercise < totalExercises) {
        currentExercise++;
        answerController.clear();
        userAnswer = '';
      } else {
        _calcularGemasFinales();
        _navigateToCompletedScreen();
      }
    });
  }

  void _calcularGemasFinales() {
    int gemasGanadas = 0;

//mas gemas
    for (int i = 0; i < totalExercises; i++) {
      if (usoGuiaPorEjercicio[i]) {
        gemasGanadas += 180; 
      } else {
        gemasGanadas += 190; 
      }
    }
    
    totalGemas = gemasGanadas;
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

  void _showExitConfirmationDialog() {
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
              Text('¿Salir del ejercicio?'),
            ],
          ),
          content: const Text(
            'Si sales ahora, perderás todo tu progreso en este ejercicio.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFE00025),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Salir',
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
        builder: (context) => EjerciciosCompletosScreen(
          totalGemas: totalGemas,
        ),
      ),
    );
  }

  Widget _buildMessageSection() {
    if (showMotivationalMessage) {
      return Container(
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
      );
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF42A5F5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text(
            '¿Te doy una guía\npara avanzar?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _handleSiButton,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF65C438),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Sí',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _handleNoButton,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE00025),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                'No',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'SEMANA 1: Ecuaciones lineales',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _showExitConfirmationDialog,
        ),
      ),

      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              children: [
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

                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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

          const SizedBox(height: 12),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
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
                              Center(
                                child: Text(
                                  _ecuacionActual,
                                  style: const TextStyle(
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
                                  keyboardType: TextInputType.numberWithOptions(signed: true),
                                  inputFormatters: [],
                                  onChanged: (value) {
                                    final numericValue = value.replaceAll(RegExp(r'[^0-9\-]'), '');
                                    if (numericValue != value) {
                                      answerController.text = numericValue;
                                      answerController.selection = TextSelection.fromPosition(
                                        TextPosition(offset: numericValue.length)
                                      );
                                    }
                                    setState(() {
                                      userAnswer = numericValue;
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

                  const SizedBox(height: 8),

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

                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
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
                      const SizedBox(width: 4),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: _buildMessageSection(),
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