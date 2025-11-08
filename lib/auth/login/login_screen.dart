import 'package:flutter/material.dart';
import '../register/register.dart';
import '../login/login.dart'; 

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            // FONDO
            Positioned(
              top: -40,
              right: -60,
              child: SizedBox(
                width: 400,
                height: 400,
                child: Image.asset(
                  'assets/images/circulos.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Stack(
                      children: [
                        Positioned(
                          top: -30,
                          right: -30,
                          child: Container(
                            width: 160,
                            height: 160,
                            decoration: const BoxDecoration(
                              color: Color(0x0D1B39FF),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          right: -20,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Color(0x141B39FF),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            // LOGO
            Positioned(
              top: 25,
              left: -60,
              child: SizedBox(
                width: 250,
                height: 120,
                child: Image.asset(
                  'assets/images/logo_text.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LA',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B39FF),
                            letterSpacing: 1.5,
                            height: 0.8,
                          ),
                        ),
                        Text(
                          'LLAMA',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B39FF),
                            letterSpacing: 1.5,
                            height: 0.8,
                          ),
                        ),
                        Text(
                          'MATEMÁTICA',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B39FF),
                            letterSpacing: 1.5,
                            height: 0.8,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            // CONTENIDO PRINCIPAL
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 30,
                left: 30,
                right: 30,
                bottom: 20,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 165),
                  
                  // IMAGEN PRINCIPAL
                  SizedBox(
                    width: 310,
                    height: 310,
                    child: Image.asset(
                      'assets/images/llama.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0x331B39FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.school,
                            size: 90,
                            color: Color(0xFF1B39FF),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 17),
                  
                  // BOTONES
                  Column(
                    children: [
                      // BOTÓN INICIAR SESIÓN
                      SizedBox(
                        width: double.infinity,
                        height: 65,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1B39FF),
                            foregroundColor: Colors.white,
                            elevation: 4,
                            shadowColor: const Color(0x331B39FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Iniciar sesión',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 15),
                      
                      // BOTÓN REGISTRARSE
                      SizedBox(
                        width: double.infinity,
                        height: 65,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Color(0xFF1B39FF),
                            side: const BorderSide(
                              color: Color(0xFF1B39FF),
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Regístrate',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 24,
                                  color: Color(0xFF1B39FF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 15),
                      
                      // BOTÓN GOOGLE
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: OutlinedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Inicio con Google próximamente'),
                                backgroundColor: const Color(0xFF616161),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black87,
                            side: const BorderSide(
                              color: Colors.black26,
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            backgroundColor: Color(0xFFF0F0F0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Image.asset(
                                  'assets/images/google_icon.png',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'G',
                                          style: TextStyle(
                                            color: Color(0xFF1B39FF),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Flexible(
                                child: Text(
                                  'Continuar con Google',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}