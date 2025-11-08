import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'auth/login/login_screen.dart';

// MAIN APP
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'La Llama Matemática',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

// SPLASH SCREEN
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  final List<Timer> _timers = [];

  @override
  void initState() {
    super.initState();
    
    // CONTROLADORES ANIMACIÓN
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _startAnimations();

    // NAVEGACIÓN
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navTimer = Timer(const Duration(seconds: 3), () {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
      _timers.add(navTimer);
    });
  }

  // INICIAR ANIMACIONES
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
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SizedBox(
                  width: 200.w,
                  height: 200.h,
                  child: Image.asset(
                    'assets/images/splash.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.orange.shade200,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.school,
                              size: 60.sp,
                              color: Colors.orange.shade800,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'LA LLAMA\nMATEMÁTICA',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF4A90E2),
                                letterSpacing: 1,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}