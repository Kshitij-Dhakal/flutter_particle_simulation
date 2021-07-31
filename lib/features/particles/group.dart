import 'particle.dart';

class Group {
  int max;
  double width;
  double height;
  List<Particle> particles;

  Group({
    required this.max,
    required this.width,
    required this.height,
    required this.particles,
  });

  void move() {
    for (var p1 in particles) {
      if (!p1.shouldMove) {
        continue;
      }
      p1.move();
      for (var p2 in particles) {
        var dist = p1.distance(p2);
        if (dist > p1.radius) {
          continue;
        }
        if (p1.shouldBounce && dist < p1.size * 2) {
          p1.reverse();
          p2.reverse();
        }
      }

      var w = width;
      var h = height;
      if (p1.bounds) {
        bounds(p1, w, h);
        continue;
      }
      bounce(p1, w, h);
    }
  }
}

// NewGroup initializes a new group of particles
Group newGroup(double width, double height, int max, Config config) {
  List<Particle> particles = [];
  for (var i = 0; i < max; i++) {
    var particle = newParticle(i, config);
    particle.randomizePosition(width, height);
    particles.add(particle);
  }

  var group = Group(
    max: max,
    width: width,
    height: height,
    particles: particles,
  );
  return group;
}
