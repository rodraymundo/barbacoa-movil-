import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; 

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  State<PantallaLogin> createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _mensajeError = "";

  void _iniciarSesion() {
    String usuario = _usuarioController.text;
    String password = _passwordController.text;

    // PRÁCTICA 5: Evitar usuario con solo espacios y validar campos vacíos
    if (usuario.trim().isEmpty || password.isEmpty) {
      setState(() {
        // Mensaje genérico, no revela qué campo falló exactamente
        _mensajeError = "Error de acceso: Verifica la información ingresada."; 
      });
      return;
    }

    // PRÁCTICA 5: Comprobar que la contraseña tenga al menos 8 caracteres
    if (password.length < 8) {
      setState(() {
        _mensajeError = "Error de acceso: Verifica la información ingresada.";
      });
      return;
    }

    // PRÁCTICA 5: Mensaje de acceso simulado válido
    if (usuario.trim().toLowerCase() == 'mesero' && password == '12345678') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Acceso seguro concedido. Iniciando sesión...'), backgroundColor: Colors.green)
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
      );
    } else {
      setState(() {
        _mensajeError = "Credenciales incorrectas.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 8))
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/logo.png', 
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // El color ahora escucha al tema
                      return Icon(Icons.storefront, size: 80, color: Theme.of(context).colorScheme.primary);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              const Text("Iniciar Sesión", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 8),
              const Text("Barbacoa OS - Acceso Móvil", style: TextStyle(color: Colors.grey, fontSize: 16)),
              const SizedBox(height: 40),

              TextField(
                controller: _usuarioController,
                decoration: InputDecoration(
                  labelText: "Usuario",
                  hintText: "Ej. mesero",
                  // El color ahora escucha al tema
                  prefixIcon: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  hintText: "Prueba: 1234",
                  // El color ahora escucha al tema
                  prefixIcon: Icon(Icons.lock, color: Theme.of(context).colorScheme.primary),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                ),
              ),
              const SizedBox(height: 15),

              if (_mensajeError.isNotEmpty) ...[
                Text(_mensajeError, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                const SizedBox(height: 15),
              ],

              ElevatedButton(
                onPressed: _iniciarSesion,
                style: ElevatedButton.styleFrom(
                  // El color ahora escucha al tema
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 55),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text("Ingresar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}