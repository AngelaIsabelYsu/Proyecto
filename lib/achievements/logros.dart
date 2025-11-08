import 'package:flutter/material.dart';
import '../widgets/appbar.dart' as appbar_file; // Para appBar y bottom navigation
import '../widgets/menu.dart' as menu_file; // Para drawer

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      
      // APPBAR desde appbar.dart (CORREGIDO)
      appBar: appbar_file.AppBarComponents.buildAppBar(context, 'Logros y Recompensas'),
      
      // DRAWER desde menu.dart
      drawer: menu_file.MenuComponents.buildDrawer(context),
      
      // CONTENIDO
      body: const _AchievementsContent(),
      
      // BOTTOM NAVIGATION desde appbar.dart
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 2),
    );
  }
}

// CONTENIDO PRINCIPAL
class _AchievementsContent extends StatelessWidget {
  const _AchievementsContent();

  @override
  Widget build(BuildContext context) {
    // Datos directamente en el widget
    final achievementsData = AchievementsData(
      totalGems: 1200,
      rewards: [
        Reward(
          id: '1',
          score: '20/20',
          title: 'Evaluación de SEM1',
          subtitle: 'Ecuaciones lineales',
          percentage: 100,
          earnedPoints: 240,
          completedAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        Reward(
          id: '2',
          score: '18/20',
          title: 'Evaluación de SEM2',
          subtitle: 'Ecuaciones lineales',
          percentage: 90,
          earnedPoints: 216,
          completedAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
        Reward(
          id: '3',
          score: '15/20',
          title: 'Evaluación de SEM3',
          subtitle: 'Ecuaciones lineales',
          percentage: 75,
          earnedPoints: 180,
          completedAt: DateTime.now().subtract(const Duration(days: 8)),
        ),
        Reward(
          id: '4',
          score: '12/20',
          title: 'Evaluación de SEM4',
          subtitle: 'Ecuaciones lineales',
          percentage: 60,
          earnedPoints: 144,
          completedAt: DateTime.now().subtract(const Duration(days: 12)),
        ),
      ],
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _GemsHeader(gems: achievementsData.totalGems),
          const SizedBox(height: 30),
          const _RewardsHeader(),
          const SizedBox(height: 20),
          _RewardsList(rewards: achievementsData.rewards),
        ],
      ),
    );
  }
}

// ENCABEZADO CON TOTAL DE GEMAS
class _GemsHeader extends StatelessWidget {
  final int gems;

  const _GemsHeader({required this.gems});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF9C88FF), 
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Total de gemas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            '💎',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(width: 8),
          Text(
            gems.toString(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ENCABEZADO DE RECOMPENSAS
class _RewardsHeader extends StatelessWidget {
  const _RewardsHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF9C88FF), Color(0xFF7C4DFF)],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C4DFF).withAlpha(51),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.card_giftcard_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Recompensas Obtenidas',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

// LISTA DE RECOMPENSAS
class _RewardsList extends StatelessWidget {
  final List<Reward> rewards;

  const _RewardsList({required this.rewards});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: rewards.map((reward) => Column(
        children: [
          _RewardCard(reward: reward),
          const SizedBox(height: 16),
        ],
      )).toList(),
    );
  }
}

// CARD DE RECOMPENSA INDIVIDUAL
class _RewardCard extends StatelessWidget {
  final Reward reward;

  const _RewardCard({required this.reward});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16), 
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge de puntos
            _PointsBadge(points: reward.earnedPoints),
            
            const SizedBox(width: 12), 
            
            // Contenido
            Expanded(
              child: _RewardContent(reward: reward),
            ),
            
            const SizedBox(width: 8), 
            
            // Ícono de logro
            _AchievementIcon(),
          ],
        ),
      ),
    );
  }
}

// BADGE DE PUNTOS
class _PointsBadge extends StatelessWidget {
  final int points;

  const _PointsBadge({required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60, 
      height: 60, 
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF9C88FF), Color(0xFF7C4DFF)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C4DFF).withAlpha(102),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '+$points',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16, 
              shadows: [
                Shadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  offset: Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          const Text(
            'PUNTOS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 8, 
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

// CONTENIDO DE RECOMPENSA
class _RewardContent extends StatelessWidget {
  final Reward reward;

  const _RewardContent({required this.reward});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          reward.title,
          style: const TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 6),
        _RewardSubtitle(subtitle: reward.subtitle),
        const SizedBox(height: 10), 
        _ProgressBar(percentage: reward.percentage),
        const SizedBox(height: 6), 
        _RewardFooter(score: reward.score, percentage: reward.percentage),
      ],
    );
  }
}

// SUBTÍTULO DE RECOMPENSA
class _RewardSubtitle extends StatelessWidget {
  final String subtitle;

  const _RewardSubtitle({required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.category_rounded,
          size: 14,
          color: Colors.grey.shade500,
        ),
        const SizedBox(width: 4),
        Expanded( 
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

// BARRA DE PROGRESO
class _ProgressBar extends StatelessWidget {
  final int percentage;

  const _ProgressBar({
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 6, 
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          height: 6, 
          width: (percentage / 100) * (MediaQuery.of(context).size.width - 200), 
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF9C88FF), Color(0xFF7C4DFF)],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C4DFF).withAlpha(77),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// FOOTER DE RECOMPENSA
class _RewardFooter extends StatelessWidget {
  final String score;
  final int percentage;

  const _RewardFooter({
    required this.score,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded( 
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 14, 
                color: Colors.green.shade600,
              ),
              const SizedBox(width: 4),
              Flexible( 
                child: Text(
                  'Puntaje: $score',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 6), 
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF9C88FF).withAlpha(26),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '$percentage%',
            style: const TextStyle(
              fontSize: 11, 
              color: Color(0xFF7C4DFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

// ÍCONO DE LOGRO 
class _AchievementIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Image.asset(
        'assets/images/llamag.png',
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.emoji_events_rounded,
            color: Color(0xFF7C4DFF),
            size: 40, 
          );
        },
      ),
    );
  }
}

// MODELOS DE DATOS

class AchievementsData {
  final int totalGems;
  final List<Reward> rewards;

  AchievementsData({
    required this.totalGems,
    required this.rewards,
  });
}

class Reward {
  final String id;
  final String title;
  final String subtitle;
  final String score;
  final int percentage;
  final int earnedPoints;
  final DateTime completedAt;

  Reward({
    required this.id,
    required this.score,
    required this.title,
    required this.subtitle,
    required this.percentage,
    required this.earnedPoints,
    required this.completedAt,
  });
}