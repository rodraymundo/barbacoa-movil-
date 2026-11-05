import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

// Definimos el color guinda como una constante para facilitar su uso
const Color colorGuinda = Color(0xFF800020); 

void main() => runApp(const BarbacoaApp());

class BarbacoaApp extends StatelessWidget {
  const BarbacoaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barbacoa OS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: colorGuinda,
          primary: colorGuinda,
          secondary: Colors.amber, // El ámbar contrasta muy bien con el guinda
        ),
        useMaterial3: true,
      ),
      home: const PantallaLogin(), 
    );
  }
}