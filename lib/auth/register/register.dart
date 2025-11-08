import 'package:flutter/material.dart';
import '../login/login.dart';
import '../../dashboard/dashboard_one.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();
  final TextEditingController _institutoController = TextEditingController();
  final TextEditingController _carreraController = TextEditingController();
  final TextEditingController _cicloController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;
  String selectedInstituto = 'Tecsup';
  String? selectedCarrera;
  String? selectedCiclo;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Validaciones
  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'El $fieldName es obligatorio';
    }
    return null;
    }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo electrónico es obligatorio';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Ingresa un correo electrónico válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es obligatoria';
    }
    if (value.length < 8) {
      return 'Mínimo 8 caracteres';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Debe contener al menos un número';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Debe contener al menos una mayúscula';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Debe contener al menos una minúscula';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirma tu contraseña';
    }
    if (value != _passwordController.text) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  // Selector de fecha 
  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF3446FF),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF3446FF),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        selectedDay = picked.day.toString().padLeft(2, '0');
        selectedMonth = picked.month.toString().padLeft(2, '0');
        selectedYear = picked.year.toString();
        _fechaNacimientoController.text = '$selectedDay/$selectedMonth/$selectedYear';
      });
    }
  }

  // Selector de instituto
  void _showInstitutoPicker() {
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
                const Text(
                  'Selecciona tu instituto',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedInstituto = 'Tecsup';
                      _institutoController.text = 'Tecsup';
                    });
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3446FF).withAlpha(26),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF3446FF),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.school, color: Color(0xFF3446FF)),
                        const SizedBox(width: 12),
                        const Text(
                          'Tecsup',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        const Spacer(),
                        if (selectedInstituto == 'Tecsup')
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF3446FF),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCarreraPicker() {
    final carreras = [
      {'name': 'Administración y Emprendimiento de Negocios Digitales', 'icon': Icons.business},
      {'name': 'Marketing Digital Analítico', 'icon': Icons.analytics},
      {'name': 'Diseño Industrial', 'icon': Icons.design_services},
      {'name': 'Tecnología de la Producción', 'icon': Icons.precision_manufacturing},
      {'name': 'Producción y Gestión Industrial', 'icon': Icons.factory},
      {'name': 'Logística Digital Integrada', 'icon': Icons.local_shipping},
      {'name': 'Gestión de Seguridad y Salud en el Trabajo', 'icon': Icons.health_and_safety},
      {'name': 'Topografía y Geomática', 'icon': Icons.public},
      {'name': 'Procesos Químicos y Metalúrgicos', 'icon': Icons.science},
      {'name': 'Operaciones Mineras', 'icon': Icons.hardware},
      {'name': 'Operación de Plantas de Procesamiento de Minerales', 'icon': Icons.settings_applications},
      {'name': 'Mantenimiento de Equipo Pesado', 'icon': Icons.construction},
      {'name': 'Mecatrónica y Gestión Automotriz', 'icon': Icons.car_repair},
      {'name': 'Gestión y Mantenimiento de Maquinaria Pesada', 'icon': Icons.build_circle},
      {'name': 'Aviónica y Mecánica Aeronáutica', 'icon': Icons.flight},
      {'name': 'Mantenimiento y Gestión de Plantas Industriales', 'icon': Icons.settings},
      {'name': 'Tecnología Mecánica Eléctrica', 'icon': Icons.electrical_services},
      {'name': 'Ciberseguridad y Auditoría Informática', 'icon': Icons.security},
      {'name': 'Diseño y Desarrollo de Software', 'icon': Icons.code},
      {'name': 'Diseño y Desarrollo de Simuladores y Videojuegos', 'icon': Icons.gamepad},
      {'name': 'Administración de Redes y Comunicaciones', 'icon': Icons.wifi},
      {'name': 'Big Data y Ciencia de Datos', 'icon': Icons.data_usage},
      {'name': 'Modelado y Animación Digital', 'icon': Icons.movie},
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(maxHeight: 500),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF87CEEB), 
                  Color(0xFFB6E6FF), 
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Selecciona tu carrera',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: carreras.length,
                    itemBuilder: (context, index) {
                      final carrera = carreras[index];
                      final isSelected = selectedCarrera == carrera['name'];
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedCarrera = carrera['name'] as String;
                              _carreraController.text = carrera['name'] as String;
                            });
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white.withAlpha(230)
                                  : Colors.white.withAlpha(180),
                              borderRadius: BorderRadius.circular(12),
                              border: isSelected
                                  ? Border.all(color: Color(0xFF87CEEB), width: 2)
                                  : Border.all(color: Colors.white.withAlpha(120), width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(20),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  carrera['icon'] as IconData,
                                  color: isSelected ? Color(0xFF87CEEB) : Colors.grey[700],
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    carrera['name'] as String,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                      color: isSelected ? Color(0xFF87CEEB) : Colors.black87,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF87CEEB),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCicloPicker() {
    final ciclos = [
      {'name': 'Primer ciclo', 'number': '1'},
      {'name': 'Segundo ciclo', 'number': '2'},
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(maxHeight: 500),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF87CEEB), 
                  Color(0xFFB6E6FF), 
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Selecciona tu ciclo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2,
                    ),
                    itemCount: ciclos.length,
                    itemBuilder: (context, index) {
                      final ciclo = ciclos[index];
                      final isSelected = selectedCiclo == ciclo['name'];
                      
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedCiclo = ciclo['name'] as String;
                            _cicloController.text = ciclo['name'] as String;
                          });
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withAlpha(200),
                            borderRadius: BorderRadius.circular(12),
                            border: isSelected
                                ? Border.all(color: Color(0xFF87CEEB), width: 2)
                                : Border.all(color: Colors.white.withAlpha(150), width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(25),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ciclo['number'] as String,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Color(0xFF87CEEB) : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Ciclo',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected ? Color(0xFF87CEEB) : Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _institutoController.text = selectedInstituto;
  }

  @override
  Widget build(BuildContext context) {
    const themeBlue = Color(0xFF3446FF);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // CARD AZUL DE ATRÁS
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height * 0.5,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF74B9FF),
                    Color(0xFF0984E3),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
          ),

          SingleChildScrollView(
            clipBehavior: Clip.none, 
            child: Column(
              children: [
                
                // HEADER CON LLAMA
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: SafeArea(
                    child: Transform.translate(
                     
                      offset: const Offset(50.0, 55.0), 
                      child: Align(
                        alignment: Alignment.topCenter, 
                        child: Image.asset(
                          'assets/images/llamitac.png',
                       
                          width: 170, 
                          height: 170, 
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.emoji_emotions,
                              size: 70, 
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                // FORMULARIO 
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 10), 
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(26),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(28),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // TÍTULO
                          const Center(
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w300,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          // CAMPO NOMBRE
                          _buildTextField(
                            controller: _nombreController,
                            label: 'Nombre',
                            icon: Icons.person,
                            validator: (value) => _validateRequired(value, 'nombre'),
                          ),

                          const SizedBox(height: 20),

                          // CAMPO APELLIDO
                          _buildTextField(
                            controller: _apellidoController,
                            label: 'Apellido',
                            icon: Icons.person_outline,
                            validator: (value) => _validateRequired(value, 'apellido'),
                          ),

                          const SizedBox(height: 20),

                          // CAMPO FECHA DE NACIMIENTO
                          _buildTextField(
                            controller: _fechaNacimientoController,
                            label: 'Fecha de nacimiento',
                            icon: Icons.calendar_today,
                            readOnly: true,
                            onTap: _showDatePicker,
                            validator: (value) => _validateRequired(value, 'fecha de nacimiento'),
                            hintText: 'DD/MM/AAAA',
                          ),

                          const SizedBox(height: 20),

                          // CAMPO INSTITUTO
                          _buildTextField(
                            controller: _institutoController,
                            label: 'Instituto',
                            icon: Icons.school,
                            readOnly: true,
                            onTap: _showInstitutoPicker,
                            validator: (value) => _validateRequired(value, 'instituto'),
                          ),

                          const SizedBox(height: 20),

                          // CAMPO CARRERA
                          _buildTextField(
                            controller: _carreraController,
                            label: 'Carrera',
                            icon: Icons.work,
                            readOnly: true,
                            onTap: _showCarreraPicker,
                            validator: (value) => _validateRequired(value, 'carrera'),
                            hintText: 'Selecciona tu carrera',
                          ),

                          const SizedBox(height: 20),

                          // CAMPO CICLO
                          _buildTextField(
                            controller: _cicloController,
                            label: 'Ciclo',
                            icon: Icons.library_books,
                            readOnly: true,
                            onTap: _showCicloPicker,
                            validator: (value) => _validateRequired(value, 'ciclo'),
                            hintText: 'Selecciona tu ciclo',
                          ),

                          const SizedBox(height: 20),

                          // CAMPO EMAIL
                          _buildTextField(
                            controller: _emailController,
                            label: 'Correo electrónico',
                            icon: Icons.email,
                            validator: _validateEmail,
                            keyboardType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 20),

                          // CAMPO CONTRASEÑA
                          _buildTextField(
                            controller: _passwordController,
                            label: 'Contraseña',
                            icon: _obscurePassword ? Icons.visibility : Icons.visibility_off,
                            obscureText: _obscurePassword,
                            validator: _validatePassword,
                            onIconTap: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),

                          const SizedBox(height: 20),

                          // CAMPO CONFIRMAR CONTRASEÑA
                          _buildTextField(
                            controller: _confirmPasswordController,
                            label: 'Confirmar contraseña',
                            icon: _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                            obscureText: _obscureConfirmPassword,
                            validator: _validateConfirmPassword,
                            onIconTap: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                          ),

                          const SizedBox(height: 32),

                          // BOTÓN REGISTRAR
                          SizedBox(
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _register,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                elevation: 4,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Registrarse',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(52, 70, 255, 0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // FOOTER - INICIAR SESIÓN
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: Image.asset(
                          'assets/images/llama.png',
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.emoji_emotions, size: 28);
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '¿Ya tienes una cuenta? ',
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Login()),
                          );
                        },
                        child: const Text(
                          'Inicia sesión',
                          style: TextStyle(
                            color: themeBlue,
                            fontWeight: FontWeight.normal, 
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    bool readOnly = false,
    bool obscureText = false,
    VoidCallback? onTap,
    VoidCallback? onIconTap,
    String? hintText,
    TextInputType? keyboardType,
  }) {
    const themeBlue = Color(0xFF3446FF);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          readOnly: readOnly,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[300]),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: themeBlue),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: themeBlue, width: 2),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                icon, 
                color: themeBlue,
                size: 20, 
              ),
              onPressed: onIconTap,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fechaNacimientoController.dispose();
    _institutoController.dispose();
    _carreraController.dispose();
    _cicloController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}