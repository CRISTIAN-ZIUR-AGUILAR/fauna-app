import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // ✅ Valor inicial definido correctamente
  String _rol = 'Usuario';

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 🔥 Oculta el botón de regresar
        title: Text(
          'Iniciar sesión',
          style: TextStyle(
            fontSize: responsive.scaleText(20),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(responsive.scale(16)),
          child: Container(
            width: Responsive.isDesktop(context)
                ? responsive.scale(400)
                : double.infinity,
            padding: EdgeInsets.all(responsive.scale(24)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(responsive.scale(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: responsive.scale(10),
                  spreadRadius: responsive.scale(2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Título del Login
                Text(
                  'Bienvenido',
                  style: TextStyle(
                    fontSize: responsive.scaleText(24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: responsive.scale(20)),

                // ✅ Campo de correo electrónico
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    prefixIcon: Icon(Icons.email, size: responsive.scale(24)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(responsive.scale(12)),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: responsive.scale(14),
                      horizontal: responsive.scale(16),
                    ),
                  ),
                  style: TextStyle(fontSize: responsive.scaleText(16)),
                ),
                SizedBox(height: responsive.scale(12)),

                // ✅ Campo de contraseña
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock, size: responsive.scale(24)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(responsive.scale(12)),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: responsive.scale(14),
                      horizontal: responsive.scale(16),
                    ),
                  ),
                  style: TextStyle(fontSize: responsive.scaleText(16)),
                ),
                SizedBox(height: responsive.scale(12)),

                // ✅ Selección de rol
                DropdownButtonFormField<String>(
                  value: _rol, // ✅ Valor inicial correctamente asignado
                  decoration: InputDecoration(
                    labelText: 'Rol',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(responsive.scale(12)),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: responsive.scale(14),
                      horizontal: responsive.scale(16),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'Usuario',
                      child: Text(
                        'Usuario',
                        style: TextStyle(fontSize: responsive.scaleText(16)),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Supervisor',
                      child: Text(
                        'Supervisor',
                        style: TextStyle(fontSize: responsive.scaleText(16)),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _rol = value!;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: responsive.scale(24),
                  ),
                ),
                SizedBox(height: responsive.scale(20)),

                // ✅ Botón de inicio de sesión
                ElevatedButton(
                  onPressed: () {
                    if (_rol == 'Usuario') {
                      Navigator.pushReplacementNamed(context, '/');
                    } else if (_rol == 'Supervisor') {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(
                      vertical: responsive.scale(14),
                      horizontal: responsive.scale(24),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(responsive.scale(12)),
                    ),
                  ),
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(
                      fontSize: responsive.scaleText(18),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: responsive.scale(12)),

                // ✅ Texto de ayuda
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Funcionalidad de recuperación no implementada',
                          style: TextStyle(
                            fontSize: responsive.scaleText(14),
                          ),
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(
                      fontSize: responsive.scaleText(14),
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
