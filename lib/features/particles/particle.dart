import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'vector.dart';

final defaultConfig = Config(
    speed: 0.5,
    radius: 80.0,
    size: 1.8,
    bounds: true,
    shouldBounce: true,
    shouldMove: true,
    color: Colors.purple[400]!);

class Config {
  double speed;
  double radius;
  double size;
  Color color;
  bool bounds;
  bool shouldBounce;
  bool shouldMove;

  Config({
    required this.speed,
    required this.radius,
    required this.size,
    required this.color,
    required this.bounds,
    required this.shouldBounce,
    required this.shouldMove,
  });

  Config copyWith({
    double? speed,
    double? area,
    double? size,
    Color? color,
    bool? bounds,
    bool? shouldBounce,
    bool? shouldMove,
  }) {
    return Config(
        speed: speed ?? this.speed,
        radius: area ?? this.radius,
        size: size ?? this.size,
        color: color ?? this.color,
        bounds: bounds ?? this.bounds,
        shouldBounce: shouldBounce ?? this.shouldBounce,
        shouldMove: shouldMove ?? this.shouldMove);
  }
}

class Particle extends Config {
  int id;
  late Vector position;
  Vector direction;

  Particle({
    required this.id,
    required this.direction,
    required Config config,
  }) : super(
            speed: config.speed,
            radius: config.radius,
            size: config.size,
            color: config.color,
            bounds: config.bounds,
            shouldBounce: config.shouldBounce,
            shouldMove: config.shouldMove);

  double distance(Particle other) {
    return this.position.distance(other.position);
  }

  void randomizePosition(double width, double height) {
    this.position = Vector(
      x: randf(0, width),
      y: randf(0, height),
    );
  }

  void reverseX() {
    this.direction.x = -this.direction.x;
  }

  void reverseY() {
    this.direction.y = -this.direction.y;
  }

  void reverse() {
    this.reverseX();
    this.reverseY();
  }

  // Move moves a particle
  void move() {
    this.position.x += (this.direction.x * this.speed);
    this.position.y += (this.direction.y * this.speed);
  }
}

Particle newParticle(int id, Config config) {
  return Particle(
    id: id,
    config: config,
    direction: Vector(
      x: randf(-100, 100) / 100.0,
      y: randf(-100, 100) / 100.0,
    ),
  );
}

// Bounce bounces a particle
void bounce(Particle p, double maxx, double maxy) {
  if (p.position.x > maxx || p.position.x < 0.0) {
    p.reverseX();
  }
  if (p.position.y > maxy || p.position.y < 0.0) {
    p.reverseY();
  }
}

// Bounds checks if a particle is within bounds
void bounds(Particle p, double maxx, double maxy) {
  if (p.position.x > maxx) {
    p.position.x = 0.0;
  }
  if (p.position.y > maxy) {
    p.position.y = 0.0;
  }

  if (p.position.x < 0.0) {
    p.position.x = maxx;
  }
  if (p.position.y < 0.0) {
    p.position.y = maxy;
  }
}
