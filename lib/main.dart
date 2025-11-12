import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../auth/login/login_screen.dart';
import '../services/gemas_service.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GemasService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Llama Matemática',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  final List<Timer> _timers = [];

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _startAnimations();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navTimer = Timer(const Duration(seconds: 3), () {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
      _timers.add(navTimer);
    });
  }

  void _startAnimations() async {
    final t1 = Timer(const Duration(milliseconds: 200), () {
      if (mounted) _scaleController.forward();
    });
    _timers.add(t1);

    final t2 = Timer(const Duration(milliseconds: 500), () {
      if (mounted) _fadeController.forward();
    });
    _timers.add(t2);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    for (final t in _timers) {
      if (t.isActive) t.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  'assets/images/splash.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.orange.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.school,
                        size: 80,
                        color: Colors.orange.shade800,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}