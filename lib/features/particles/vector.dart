import 'dart:math';

import 'package:flutter_particle_demo/commons/utils/random_utils.dart';

class Vector {
  double x;
  double y;
  Vector({
    this.x = 0,
    this.y = 0,
  });

  double distance(Vector other) {
  return sqrt(pow(other.x - this.x, 2) + pow(other.y - this.y, 2));
}
}

double randf(double min, double max) {
  return (getRandomInt(max.toInt()) + min).toDouble();
}
