import 'package:flutter/material.dart';

import 'group.dart';
import 'particle.dart';
import 'particle_painter.dart';
import 'vector.dart';

class AnimatedParticles extends StatefulWidget {
  static final routeName = '/particle-demo';

  const AnimatedParticles({Key? key}) : super(key: key);

  @override
  AnimatedParticlesState createState() => AnimatedParticlesState();
}

class AnimatedParticlesState extends State<AnimatedParticles>
    with SingleTickerProviderStateMixin {
  Group? g;
  late AnimationController _controller;
  late Animation<double> animation;
  double x = 0.0;
  double y = 0.0;

  void _updateLocation(PointerEvent details) {
    x = details.position.dx;
    y = details.position.dy;

    var mouse = g?.particles[0];
    if (mouse != null) {
      mouse.shouldMove = false;
      mouse.radius = 120;
      mouse.position = Vector(x: x, y: y);
    }
  }

  void _onExit(PointerEvent details) {
    x = details.position.dx;
    y = details.position.dy;
    var mouse = g?.particles[0];
    if (mouse != null) {
      mouse.shouldMove = true;
      mouse.radius = 80;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    Tween<double> tween = Tween(begin: 0, end: 1);
    animation = tween.animate(_controller)
      ..addListener(() {
        setState(() {
          g?.move();
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (g == null) {
      g = newGroup(size.width, size.height, 130, defaultConfig);
    }
    return MouseRegion(
      onHover: _updateLocation,
      onExit: _onExit,
      child: Container(
        color: Colors.black87,
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) => CustomPaint(
            painter: ParticlePainter(group: g!, animation: animation.value),
          ),
        ),
      ),
    );
  }
}
