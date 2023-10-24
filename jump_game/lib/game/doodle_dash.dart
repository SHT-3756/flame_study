import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:jump_game/game/sprites/sprites.dart';
import 'package:jump_game/game/world.dart';

import 'managers/managers.dart';

enum Character { dash, sparky }

class DoodleDash extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {
  final World _world = World();
  GameManager gameManager = GameManager();
  LevelManager levelManager = LevelManager();
  ObjectManager objectManager = ObjectManager();
  int screenBufferSpace = 300;

  // late Player player;

  @override
  Future<void> onLoad() async {
    await add(_world);

    await add(gameManager);

    overlays.add('gameOverlay');

    await add(levelManager);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // TODO : game over 추가
    // 게임 상태 인트로 화면일 때
    if (gameManager.isIntro) {
      overlays.add('mainMenuOverlay');
      return;
    } else if (gameManager.isPlaying) {
      // 게임 진행중일 떄
      checkLevelUp();

      // Core gameplay: Add camera code to follow Dash during game play

      // Losing the game: Add the first loss condition.
      // Game over if Dash falls off screen!
    }
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 241, 247, 249);
  }

  void initialGameStart() {
    // Add a Player to the game: Call setCharacter

    gameManager.reset();

    if (children.contains(objectManager)) objectManager.removeFromParent();

    levelManager.reset();

    // Core gameplay: Reset player & camera boundaries

    // Add a Player to the game: Reset Dash's position back to the start

    objectManager = ObjectManager(
      minVerticalDistanceToNextPlatform: levelManager.minDistance,
      maxVerticalDistanceToNextPlatform: levelManager.maxDistance,
    );

    add(objectManager);

    objectManager.configure(levelManager.level, levelManager.difficulty);
  }

  // 캐릭터 선택
  void setCharacter() {
    // 캐릭터 초기화
    // 캐릭터 추가하기
  }

  // 게엠 시작
  void startGame() {
    initialGameStart();
    gameManager.state = GameState.playing;
    overlays.remove('mainMenuOverlay');
  }

  // TODO : 게임 졌을때

  // 게임 리셋
  void resetGame() {
    startGame();
    overlays.remove('gameOverOverlay');
  }

  // 게임 토글 버튼 상태 (실행, 일시 정지)
  void togglePauseState() {
    if (paused) {
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

      objectManager.configure(levelManager.level, levelManager.difficulty);

      // Core gameplay: Call setJumpSpeed
    }
  }
}
