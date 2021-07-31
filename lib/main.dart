import 'package:flutter/material.dart';
import 'package:flutter_particle_demo/features/particles/particle_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Particles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateTitle: (context) => 'Flutter Particles Demo',
      home: AnimatedParticles(),
    );
  }
}
