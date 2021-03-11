import 'dart:math';

double locationOffset() {
  final random = Random();
  int sign = random.nextBool() ? 1 : -1;
  return sign * random.nextDouble() / 100;
}
