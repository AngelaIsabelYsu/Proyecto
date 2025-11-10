import 'package:flutter/material.dart';
import 'ejercicios.dart'; 
import '../../widgets/appbar.dart' as appbar_file; 

class Exercise {
  final int number;
  final String title;
  final bool isCompleted;
  final bool isLocked;
  final bool isActive;

  const Exercise({
    required this.number,
    required this.title,
    required this.isCompleted,
    required this.isLocked,
    this.isActive = false,
  });
}

class ExerciseItem {
  final int number;
  final String title;
  final String subtitle;
  final bool isLocked;
  final bool isActive;
  final bool isCompleted;

  ExerciseItem({
    required this.number,
    required this.title,
    required this.subtitle,
    this.isLocked = true,
    this.isActive = false,
    this.isCompleted = false,
  });
}

class SemanaEjerciciosScreen extends StatefulWidget {
  final String weekTitle;
  final int weekNumber;
  final bool isCompleted;

  const SemanaEjerciciosScreen({
    super.key,
    required this.weekTitle,
    this.weekNumber = 1,
    this.isCompleted = false,
  });

  @override
  State<SemanaEjerciciosScreen> createState() => _SemanaEjerciciosScreenState();
}

class _SemanaEjerciciosScreenState extends State<SemanaEjerciciosScreen> {
  final int _completedExercises = 0; 
  final int _totalExercises = 4;

  late List<ExerciseItem> _exercises;

  @override
  void initState() {
    super.initState();
    _initializeExercises();
  }

  void _initializeExercises() {
    if (widget.isCompleted) {
      _exercises = [
        ExerciseItem(
          number: 1,
          title: 'Ejercicio N° 1',
          subtitle: 'Completado',
          isLocked: false,
          isActive: false,
          isCompleted: true,
        ),
        ExerciseItem(
          number: 2,
          title: 'Ejercicio N° 2',
          subtitle: 'Completado',
          isLocked: false,
          isActive: false,
          isCompleted: true,
        ),
        ExerciseItem(
          number: 3,
          title: 'Ejercicio N° 3',
          subtitle: 'Completado',
          isLocked: false,
          isActive: false,
          isCompleted: true,
        ),
        ExerciseItem(
          number: 4,
          title: 'Ejercicio N° 4',
          subtitle: 'Completado',
          isLocked: false,
          isActive: false,
          isCompleted: true,
        ),
      ];
    } else {
      _exercises = [
        ExerciseItem(
          number: 1,
          title: 'Ejercicio N° 1',
          subtitle: 'Haz click para comenzar',
          isLocked: false,
          isActive: true,
        ),
        ExerciseItem(
          number: 2,
          title: 'Ejercicio N° 2',
          subtitle: 'Incompleto',
          isLocked: true,
        ),
        ExerciseItem(
          number: 3,
          title: 'Ejercicio N° 3',
          subtitle: 'Incompleto',
          isLocked: true,
        ),
        ExerciseItem(
          number: 4,
          title: 'Ejercicio N° 4',
          subtitle: 'Incompleto',
          isLocked: true,
        ),
      ];
    }
  }

  void _onExerciseTap(ExerciseItem exercise) {
    if (widget.isCompleted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${exercise.title} ya está completado'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (exercise.isLocked) {
      _showLockedDialog();
      return;
    }

    if (exercise.number == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EjerciciosScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Abriendo ${exercise.title}'),
          backgroundColor: const Color(0xFF0984E3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showLockedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.lock, color: Color(0xFF0984E3)),
            SizedBox(width: 8),
            Text('Ejercicio bloqueado'),
          ],
        ),
        content: const Text(
          'Completa los ejercicios anteriores para desbloquear este.',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_file.AppBarComponents.buildBackAppBar(
        context, 
        widget.isCompleted ? '${widget.weekTitle} - Completado!' : widget.weekTitle
      ),
      body: Column(
        children: [
          _buildProgressBar(), 
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                children: [
                  ..._exercises.map((exercise) => ExerciseCard(
                        exercise: exercise,
                        onTap: () => _onExerciseTap(exercise),
                        isCompletedVersion: widget.isCompleted,
                      )),
                  
                  const SizedBox(height: 12), 
                  _buildBottomSection(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 1),
    );
  }

  Widget _buildProgressBar() {
    final progress = _totalExercises > 0 
        ? _completedExercises / _totalExercises 
        : 0.0;
    
    final progressFill = LayoutBuilder(
      builder: (context, constraints) {
        final minWidth = progress > 0 ? 20.0 : 0.0;
        final calculatedWidth = constraints.maxWidth * progress;
        
        return Container(
          height: 14,
          width: calculatedWidth < minWidth ? minWidth : calculatedWidth,
          decoration: BoxDecoration(
            color: widget.isCompleted ? Colors.green : const Color(0xFFFDD835),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF0984E3),
                      width: 1.5,
                    ),
                  ),
                ),
                
                Align(
                  alignment: Alignment.centerLeft,
                  child: progressFill,
                ),

                Text(
                  '$_completedExercises/$_totalExercises',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 12),
          
          Icon(
            Icons.emoji_events, 
            color: widget.isCompleted ? Colors.green : Colors.amber[700], 
            size: 32,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 220,
            height: 220,
            child: Image.asset(
              'assets/images/llama.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEAA7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.emoji_emotions,
                    color: widget.isCompleted ? Colors.green : const Color(0xFFE17055),
                    size: 90,
                  ),
                );
              },
            ),
          ),
          
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: widget.isCompleted ? Colors.green : const Color(0xFFE53935),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: (widget.isCompleted ? Colors.green : const Color(0xFFE53935)).withAlpha(102),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.isCompleted 
                          ? '¡Felicidades! Has completado todos los ejercicios de esta semana'
                          : 'En cada desafío matemático, hay una llama que te espera para ser encendida',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: widget.isCompleted ? Colors.green : const Color(0xFF0984E3),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(20),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Puntaje actual:',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '0/20',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: widget.isCompleted ? Colors.green : const Color(0xFF0984E3),
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
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final ExerciseItem exercise;
  final VoidCallback onTap;
  final bool isCompletedVersion;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onTap,
    required this.isCompletedVersion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isCompletedVersion 
                  ? const Color(0xFFFDD835)
                  : (exercise.isActive
                      ? const Color(0xFFFDD835)
                      : Colors.grey[200]),
              borderRadius: BorderRadius.circular(16),
              boxShadow: isCompletedVersion || exercise.isActive
                  ? [
                      BoxShadow(
                        color: const Color(0xFFFDD835).withAlpha(77),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isCompletedVersion 
                              ? Colors.black87 
                              : (exercise.isLocked
                                  ? Colors.grey[600]
                                  : Colors.black87),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        exercise.subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: isCompletedVersion 
                              ? Colors.grey[700]
                              : (exercise.isLocked
                                  ? Colors.grey[500]
                                  : Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ),
              
                _buildIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (isCompletedVersion || exercise.isCompleted) {
      return Icon(
        Icons.check_circle,
        color: Colors.green[600],
        size: 26,
      );
    }

    if (exercise.isActive) {
      return Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Color(0xFF0984E3),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.rocket_launch,
          color: Colors.white,
          size: 22,
        ),
      );
    }

    return Icon(
      Icons.lock,
      color: Colors.grey[600],
      size: 26,
    );
  }
}