import 'package:flutter/material.dart';
import 'dart:async';
import 'home_screen.dart'; // Asegúrate de importar tu pantalla principal

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navegar a la pantalla principal después de 3 segundos
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo o imagen del splash screen
            Image.asset('assets/logo.png', width: 200, height: 200),
            SizedBox(height: 20),
            // Texto del splash screen
            Text(
              'Bienvenido a Cat Breeds',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}