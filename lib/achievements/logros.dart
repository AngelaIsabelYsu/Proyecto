import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/appbar.dart' as appbar_file; 
import '../widgets/menu.dart' as menu_file; 
import '../services/gemas_service.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: appbar_file.AppBarComponents.buildAppBar(context, 'Logros y Recompensas'),
      drawer: menu_file.MenuComponents.buildDrawer(context),
      body: const _AchievementsContent(),
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 2),
    );
  }
}

class _AchievementsContent extends StatelessWidget {
  const _AchievementsContent();

  @override
  Widget build(BuildContext context) {
    final gemasService = Provider.of<GemasService>(context);
    
    final achievementsData = AchievementsData(
      totalGems: gemasService.totalGemas,
      totalPoints: 2150,
      rewards: [
        Reward(
          id: '1',
          score: '20/20',
          title: 'Evaluación de SEM1',
          subtitle: 'Ecuaciones lineales',
          earnedPoints: 240,
          earnedGems: 24,
          completedAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        Reward(
          id: '2',
          score: '18/20',
          title: 'Evaluación de SEM2',
          subtitle: 'Ecuaciones lineales',
          earnedPoints: 216,
          earnedGems: 22,
          completedAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
        Reward(
          id: '3',
          score: '15/20',
          title: 'Evaluación de SEM3',
          subtitle: 'Ecuaciones lineales',
          earnedPoints: 180,
          earnedGems: 18,
          completedAt: DateTime.now().subtract(const Duration(days: 8)),
        ),
        Reward(
          id: '4',
          score: '12/20',
          title: 'Evaluación de SEM4',
          subtitle: 'Ecuaciones lineales',
          earnedPoints: 144,
          earnedGems: 14,
          completedAt: DateTime.now().subtract(const Duration(days: 12)),
        ),
      ],
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StatsHeader(
            gems: achievementsData.totalGems,
            points: achievementsData.totalPoints,
          ),
          const SizedBox(height: 30),
          const _RewardsHeader(),
          const SizedBox(height: 20),
          _RewardsList(rewards: achievementsData.rewards),
        ],
      ),
    );
  }
}

class _StatsHeader extends StatelessWidget {
  final int gems;
  final int points;

  const _StatsHeader({required this.gems, required this.points});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFD92A2A), 
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
                  '💎',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 6),
                Text(
                  gems.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Gemas',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50), 
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
                  '⭐',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 6),
                Text(
                  points.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Puntos',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _PointsBadge(
              points: reward.earnedPoints,
              gems: reward.earnedGems,
            ),
            const SizedBox(width: 12), 
            Expanded(
              child: _RewardContent(reward: reward),
            ),
            const SizedBox(width: 8), 
            _AchievementIcon(),
          ],
        ),
      ),
    );
  }
}

class _PointsBadge extends StatelessWidget {
  final int points;
  final int gems;

  const _PointsBadge({required this.points, required this.gems});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65, 
      height: 65, 
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
              fontSize: 15,
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
            'pts',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '💎',
                style: TextStyle(fontSize: 10),
              ),
              const SizedBox(width: 2),
              Text(
                '+$gems',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
        _RewardFooter(score: reward.score),
      ],
    );
  }
}

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

class _RewardFooter extends StatelessWidget {
  final String score;

  const _RewardFooter({
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.check_circle_rounded,
          size: 14,
          color: Colors.green.shade600,
        ),
        const SizedBox(width: 4),
        Text(
          'Puntaje: $score',
          style: TextStyle(
            fontSize: 12,
            color: Colors.green.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

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

class AchievementsData {
  final int totalGems;
  final int totalPoints;
  final List<Reward> rewards;

  AchievementsData({
    required this.totalGems,
    required this.totalPoints,
    required this.rewards,
  });
}

class Reward {
  final String id;
  final String title;
  final String subtitle;
  final String score;
  final int earnedPoints;
  final int earnedGems;
  final DateTime completedAt;

  Reward({
    required this.id,
    required this.score,
    required this.title,
    required this.subtitle,
    required this.earnedPoints,
    required this.earnedGems,
    required this.completedAt,
  });
}