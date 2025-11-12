import 'package:flutter/material.dart';
import '../../widgets/appbar.dart' as appbar_file; 

class GuiaSolucionScreen extends StatelessWidget {
  const GuiaSolucionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_file.AppBarComponents.buildBackAppBar(
        context, 
        'SEMANA 1: Ecuaciones lineales'
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: Colors.white, 
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/guia.png',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 12),
                const Text(
                  'GUÍA DE SOLUCIÓN',
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildStepCard(
            '1. Distribuye los números que están multiplicando paréntesis en ambos lados de la ecuación:',
            [
              'Multiplica 6 por cada término dentro del paréntesis.',
              'Haz lo mismo con el 13 en el otro lado.',
            ],
          ),
          const SizedBox(height: 12),
          _buildStepCard(
            '2. Suma o resta términos semejantes:',
            [
              'En el lado derecho, después de distribuir, deberías combinar los términos constantes con el −14.',
            ],
          ),
          const SizedBox(height: 12),
          _buildStepCard(
            '3. Pasa todos los términos con \'x\' a un lado de la ecuación y los números constantes) al otro. Usa suma o resta para moverlos.',
            [],
          ),
          const SizedBox(height: 12),
          _buildStepCard(
            '4. Simplifica ambos lados para dejar una ecuación del tipo ax = b.',
            [],
          ),
          const SizedBox(height: 12),
          _buildStepCard(
            '5. Finalmente, divide ambos lados entre el coeficiente de x para encontrar el valor de x.',
            [],
                          ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 1),
    );
  }

  Widget _buildStepCard(String title, List<String> bullets) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF48FB1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1A1A1A),
              fontSize: 15,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          if (bullets.isNotEmpty) ...[
            const SizedBox(height: 8),
            ...bullets.map((bullet) => Padding(
              padding: const EdgeInsets.only(left: 16, top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '• ',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      bullet,
                      style: const TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ],
      ),
    );
  }
}