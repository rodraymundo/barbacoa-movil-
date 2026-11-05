import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:barbacoa_os_mobile/screens/login_screen.dart'; // Ajusta "barbacoa_os" al nombre real de tu proyecto

// FASE 2: Lógica aislada (Dobles de prueba / Simulador del backend)
String? validarLoginSimulado(String usuario, String password) {
  if (usuario.trim().isEmpty || password.isEmpty) return "vacío";
  if (password.length < 8) return "corto";
  if (usuario == 'mesero' && password == '12345678') return "ok";
  return "incorrecto";
}

void main() {
  group('Fase 2: Pruebas Unitarias (Lógica de Negocio)', () {
    test('1. Caso válido: Credenciales correctas devuelven ok', () {
      expect(validarLoginSimulado('mesero', '12345678'), 'ok'); // Caso válido
    });

    test('2. Caso límite: Contraseña con exactamente 7 caracteres falla', () {
      expect(validarLoginSimulado('mesero', '1234567'), 'corto'); // Caso límite
    });

    test('3. Caso inválido: Campos vacíos devuelven error', () {
      expect(validarLoginSimulado(' ', ''), 'vacío'); // Caso de error
    });
  });

  group('Fase 3: Pruebas de Integración (Formulario y Validación)', () {
    testWidgets('1. Interacción: Mostrar error genérico al dejar campos vacíos', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PantallaLogin()));
      
      // Tap en el botón sin escribir nada
      await tester.tap(find.text('Ingresar'));
      await tester.pump(); // Reconstruye la UI
      
      // Verifica que el mecanismo de validación rechace la acción
      expect(find.text('Error de acceso: Verifica la información ingresada.'), findsOneWidget);
    });

    testWidgets('2. Interacción: Ingresar credenciales incorrectas muestra rechazo', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PantallaLogin()));
      
      // Llenar formulario
      await tester.enterText(find.byType(TextField).first, 'mesero');
      await tester.enterText(find.byType(TextField).last, 'admin1234');
      await tester.tap(find.text('Ingresar'));
      await tester.pump();
      
      // Verifica conexión entre inputs y respuesta visual
      expect(find.text('Credenciales incorrectas.'), findsOneWidget);
    });
  });
}