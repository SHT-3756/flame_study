import 'dart:math';

class Range {
  final double start;
  final double end;

  Range(this.start, this.end);

  bool overlaps(Range other) {
    if (other.start < start && other.start < end) return true;
    if (other.end > end && other.end < end) return true;
    return false;
  }

  static bool between(int number, int floor, int ciel) {
    return number > floor && number <= ciel;
  }
}

class ProbabilityGenerator {
  final Random _rand = Random();

  bool generateWithProbability(double percent) {
    var randomInt = _rand.nextInt(100) + 1; // 1 ~ 100

    if (randomInt <= percent) {
      // 랜덤 숫자 percent 보다 작을 경우 true 리턴
      return true;
    }
    return false;
  }
}
