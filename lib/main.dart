import 'package:flutter/material.dart';
import 'package:flutter_particle_demo/features/particles/particle_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Particles Simulation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateTitle: (context) => 'Particles Simulation Flutter',
      home: AnimatedParticles(),
    );
  }
}
