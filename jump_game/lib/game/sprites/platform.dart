import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:jump_game/game/doodle_dash.dart';

// TODO : 충돌을 감지하기 위한 플랫폼인가 ? ?
abstract class Platform<T> extends SpriteGroupComponent<T> with HasGameRef<DoodleDash>, CollisionCallbacks {
  final hitBox = RectangleHitbox();
  bool isMoving = false;

  // TODO : 이동 감지 하기 위함인가 ? ?
  double direction = 1;
  final Vector2 _velocity = Vector2.zero();
  double speed = 35;

  Platform({
    super.position,
  }) : super(
          size: Vector2.all(100),
          priority: 2,
        );

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    await add(hitBox);

    final int rand = Random().nextInt(100);
    if (rand > 80) isMoving = true;

  }

  // 이동
  void _move(double dt) {
    if (!isMoving) return;

    final double gameWidth = gameRef.size.x;

    if (position.x <= 0) {
      // 왼쪽으로 이동시
      direction = 1;
    } else if (position.x >= gameWidth - size.x) {
      // 유저의 x 위치 >= 게임 사이즈 - 컴포넌트의 논리적 x 크기 (화면에 그려질 객체 크기)
      direction = -1;
    }
  }

  @override
  void update(double dt) {
    _move(dt);
    super.update(dt);
  }
}
enum NormalPlatformState {only}

class NormalPlatform extends Platform<NormalPlatformState> {
  NormalPlatform({super.position});

  final Map<String, Vector2> spriteOptions = {
    'platform_monitor': Vector2(115, 84),
    'platform_phone_center': Vector2(100, 55),
    'platform_terminal': Vector2(110, 83),
    'platform_laptop': Vector2(100, 63),
  };
  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    var randSpriteIndex = Random().nextInt(spriteOptions.length);

    String randSprite = spriteOptions.keys.elementAt(randSpriteIndex);

    sprites = {
      NormalPlatformState.only : await gameRef.loadSprite('game/$randSprite.png')
    };

    current = NormalPlatformState.only;

    size = spriteOptions[randSprite]!;


  }

}

enum BrokenPlatformState {cracked, broken}

class BrokenPlatform extends Platform<BrokenPlatformState> {
  BrokenPlatform({super.position});

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    sprites = <BrokenPlatformState, Sprite> {
      BrokenPlatformState.cracked:
      await gameRef.loadSprite('game/platform_cracked_monitor.png'),
      BrokenPlatformState.broken:
      await gameRef.loadSprite('game/platform_monitor_broken.png'),
    };

    current = BrokenPlatformState.cracked;
    size = Vector2(115, 84);
  }

  void breakPlatform() {
    current = BrokenPlatformState.broken;
  }
}


enum SpringState { down, up }

class SpringBord extends Platform<SpringState> {
  SpringBord({super.position});

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    sprites = <SpringState, Sprite>{
      SpringState.down: await gameRef.loadSprite('game/platform_trampoline_down.png'),
      SpringState.up: await gameRef.loadSprite('game/platform_trampoline_up.png'),
    };

    current = SpringState.up;

    size = Vector2(100, 45);
  }

  // 충돌 시작시
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    // 수직 충돌 여부
    bool isCollidingVertically = (intersectionPoints.first.y - intersectionPoints.last.y).abs() < 5;
    if (isCollidingVertically) {
      // 스프링 보드 상태 변경
      current = SpringState.down;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    current = SpringState.up;
  }
}

enum EnemyPlatformState {only}

class EnemyPlatform extends Platform<EnemyPlatformState> {
  EnemyPlatform({super.position});

  @override
  Future<void>? onLoad() async {
    var randBool = Random().nextBool();
    var enemySprite = randBool ? 'enemy_trash_can' : 'enemy_error';

    sprites = <EnemyPlatformState, Sprite> {
      EnemyPlatformState.only :
          await gameRef.loadSprite('game/$enemySprite.png'),
    };

    current = EnemyPlatformState.only;

    return super.onLoad();
  }
}
