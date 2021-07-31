import 'dart:math';

Random _random = new Random();

int getRandomInt(int limit) => _random.nextInt(limit);

double randomDouble() => _random.nextDouble();
