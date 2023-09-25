import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

enum PlayerState { idle, running }

enum PlayerDirection { left, right, none }

// 키보드를 사용하기 위함(KeyboardHandler)
class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, KeyboardHandler {

  String character;

  Player({position, this.character = 'Ninja Frog'}) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime = 0.05;
  bool isFacingRight = true; // 왼쪽을 바라보는지 유무

  PlayerDirection playerDirection = PlayerDirection.none;
  double moveSpeed = 100; // default 이동 속도 100
  Vector2 velocity = Vector2.zero();

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // 게임 개발에는 델다 시간을 많이 사용한다.
    _updatePlayerMovement(dt);
    super.update(dt); // 많은 프레임을 업데이트 가능하다. 10 프레임은 1초에 10번 업데이트 한다.
    // 정확한 업데이트 량을 정해서 1초마다 일정하게 프레임 업데이트를 시켜준다.
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // a or 물리적으로 왼쪽 화살표
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);

    // d or 물리적으로 오른쪽 화살표
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);

    // 동시 키 누르면
    if (isLeftKeyPressed && isRightKeyPressed) {
      playerDirection = PlayerDirection.none;
    } else if (isLeftKeyPressed) {
      playerDirection = PlayerDirection.left;
    } else if (isRightKeyPressed) {
      playerDirection = PlayerDirection.right;
    } else {
      playerDirection = PlayerDirection.none;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('Idle', 11);

    runningAnimation = _spriteAnimation('Run', 12);

    // 모든 애니메이션 리스트
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
    };

    // 현재 애니메이션 설정
    current = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/$character/$state (32x32).png'),
      SpriteAnimationData.sequenced(
        // 애니메이션 만들기
        amount: amount, // 실제 캐릴터 이미지 수 11 단계
        stepTime: stepTime, // 프레임 밀리초
        textureSize: Vector2.all(32), // x 32, y 32 사이즈
      ),
    );
  }

  // 플레이어 위치 이동
  void _updatePlayerMovement(double dt) {
    double dirX = 0.0;
    switch (playerDirection) {
      case PlayerDirection.left:
        if (isFacingRight) {
          flipHorizontallyAroundCenter(); // 캐릭터 중심으로 뒤집는다. (중앙 중심으로 수평으로 뒤집는다.)
          isFacingRight = false;
        }
        current = PlayerState.running;
        dirX -= moveSpeed;
        break;
      case PlayerDirection.right:
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        current = PlayerState.running;
        dirX += moveSpeed;
        break;
      case PlayerDirection.none:
        current = PlayerState.idle;
        break;
      default:
    }

    // 플레이어 방향 기반으로 방향 x 를 설정했으니 실제 속도에 추가해야하는 코드
    velocity = Vector2(dirX, 0.0);
    // 속도를 플레이어 위치로 설정하면 위치를 호출할 수 있다.
    position += velocity * dt; // 100 의 이동속도로 움직인다.
  }
}
