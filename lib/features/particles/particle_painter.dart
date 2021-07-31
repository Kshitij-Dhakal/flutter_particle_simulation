import 'package:flutter/rendering.dart';

import 'group.dart';
import 'particle.dart';

class ParticlePainter extends CustomPainter {
  Group group;
  double animation;

  ParticlePainter({required this.group, required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    for (var p1 in group.particles) {
      _drawParticle(canvas, p1);
      for (var p2 in group.particles) {
        if (p1.distance(p2) < p1.radius) {
          _drawConnection(canvas, p1, p2);
        }
      }
    }
  }

  void _drawParticle(Canvas canvas, Particle p) {
    canvas.drawCircle(
      Offset(p.position.x, p.position.y),
      2,
      Paint()
        ..strokeWidth = 1
        ..style = PaintingStyle.fill
        ..color = p.color,
    );
  }

  void _drawConnection(Canvas canvas, Particle p1, Particle p2) {
    var dist = p1.distance(p2);
    var alpha = ((1.0 - (dist / p1.radius)) * 255).toInt();
    var iniColor = p1.color;
    var color =
        Color.fromARGB(alpha, iniColor.red, p1.color.green, p1.color.blue);

    canvas.drawLine(
      Offset(p1.position.x, p1.position.y),
      Offset(p2.position.x, p2.position.y),
      Paint()
        ..strokeWidth = 1
        ..style = PaintingStyle.fill
        ..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
