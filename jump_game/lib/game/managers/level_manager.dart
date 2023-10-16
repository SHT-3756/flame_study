import 'package:flame/components.dart';
import 'package:jump_game/game/doodle_dash.dart';
import 'package:jump_game/game/model/model.dart';

class LevelManager extends Component with HasGameRef<DoodleDash> {
  // 선택한 레벨
  int selectedLevel;

  // 현재 레벨
  int level;

  LevelManager({this.selectedLevel = 1, this.level = 1});

  // 레벨 설정
  final Map<int, DifficultyModel> levelsConfig = {
    1: const DifficultyModel(minDistance: 200, maxDistance: 300, jumpSpeed: 600, score: 0),
    2: const DifficultyModel(minDistance: 200, maxDistance: 400, jumpSpeed: 650, score: 20),
    3: const DifficultyModel(minDistance: 200, maxDistance: 500, jumpSpeed: 700, score: 40),
    4: const DifficultyModel(minDistance: 200, maxDistance: 600, jumpSpeed: 750, score: 80),
    5: const DifficultyModel(minDistance: 200, maxDistance: 700, jumpSpeed: 800, score: 100),
  };

  // getter
  double get minDistance {
    return levelsConfig[level]!.minDistance;
  }

  double get maxDistance {
    return levelsConfig[level]!.maxDistance;
  }

  double get startingJumpSpeed {
    return levelsConfig[selectedLevel]!.jumpSpeed;
  }

  double get jumpSpeed {
    return levelsConfig[level]!.jumpSpeed;
  }

  DifficultyModel get difficulty {
    return levelsConfig[level]!;
  }


  // function
  // 레벨업 해서 정해놓은 점수에 도달했는지 확인하는 함수
  bool shouldLevelUp(int score) {
    int nextLevel = level + 1;

    if (levelsConfig.containsKey(nextLevel)) {
      // 레벨 2 이면, 정해놓은 점수 20점과 파라미터 넘어론 20이 같으면 true 반환
      return levelsConfig[nextLevel]!.score == score;
    }

    return false;
  }

  // 레벨 증가
  void increaseLevel() {
    // 현재 레벨이 설정 config 키 크기 보다 작으면 레벨업 시킨다.
    if (level < levelsConfig.keys.length) {
      level++;
    }
  }

  // 새로운 레벨 세팅
  void setLevel(int newLevel) {
    // newLevel 의 값이 설정 config 의 키값과 돌일하면 적용
    if (levelsConfig.containsKey(newLevel)) {
      level = newLevel;
    }
  }

  // 선택 레벨
  void selectLevel(int selectLevel) {
    // 선택한 레벨이 설정 config 키 값과 동일하면 적용
    if (levelsConfig.containsKey(selectLevel)) {
      selectedLevel = selectLevel;
    }
  }

  // 리셋
  void reset() {
    level = selectedLevel;
  }
}
