import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:jump_game/game/world.dart';

import 'managers/managers.dart';

enum Character {dash, sparky}

class DoodleDash extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {

  final World _world = World();
  GameManager gameManager = GameManager();
  LevelManager levelManager = LevelManager();
  ObjectManager objectManager = ObjectManager();

  int screenBufferSpace = 300;

  @override
  FutureOr<void> onLoad() {
    add(_world);
    add(gameManager);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // TODO : game over 추가
    // 게임 상태 인트로 화면일 때
    if(gameManager.isIntro) {

    } else if(gameManager.isPlaying) { // 게임 진행중일 떄
      checkLevelUp();
    }
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 241, 247, 249);
  }

  void initialGameStart() {

  }

  // 게임 토글 버튼 상태 (실행, 일시 정지)
  void togglePauseState() {
    if(paused) {
      resumeEngine();
    } else {
      pauseEngine();
    }
  }

  // 레벨업 체크하는 함수
  void checkLevelUp() {
    // 현재 레벤이 가능할 때, 레벨이 내가 정해놓은 config 에 도달 했을때
    if (levelManager.shouldLevelUp(gameManager.score.value)) {
      levelManager.increaseLevel();

      // objectManager.configure(levelManager.level, levelManager.difficulty);

      // Core gameplay: Call setJumpSpeed
    }
  }
}
