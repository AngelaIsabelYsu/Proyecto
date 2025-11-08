import 'package:flutter/material.dart';
import '../../widgets/appbar.dart' as appbar_file; // IMPORTAR APP BAR

class GuiaSolucionScreen extends StatelessWidget {
  const GuiaSolucionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR IMPORTADO CON MÓDULO RESALTADO
      appBar: appbar_file.AppBarComponents.buildAppBar(
        context, 
        'SEMANA 1: Ecuaciones lineales'
      ),
      body: Column(
        children: [
          // Header con título "GUIA DE SOLUCION" - FUERA DEL APPBAR Y CON FONDO BLANCO
          Container(
            color: Colors.white, // FONDO BLANCO
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Icono temporal en lugar de la imagen que no carga
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF42A5F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.help_outline, // Icono temporal
                    color: Colors.white,
                    size: 20,
                  ),
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
                const Spacer(),
                // Botón de retroceso circular
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF42A5F5).withAlpha(25),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, 
                            color: Color(0xFF42A5F5), 
                            size: 18),
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Lista de pasos
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
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
      // BOTTOM NAVIGATION BAR CON MÓDULO RESALTADO
      bottomNavigationBar: appbar_file.AppBarComponents.buildBottomNavBar(context, 1),
    );
  }

  Widget _buildStepCard(String title, List<String> bullets) {
    return Container(
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