import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:pixel_adventure/components/utils.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

import 'collision_block.dart';

enum PlayerState { idle, running }

// 키보드를 사용하기 위함(KeyboardHandler)
class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, KeyboardHandler {
  String character;

  Player({position, this.character = 'Ninja Frog'}) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime = 0.05;

  final double _gravity = 9.8; // 중력
  final double _jumpForce = 460; // 더플점프를 할 것임
  final double _terminalVelocity = 300; // 종단 속도
  double horizontalMovement = 0; // 수평 이동
  double moveSpeed = 100; // default 이동 속도 100
  Vector2 velocity = Vector2.zero();
  bool isOnGround = false; // 플레이어의 위치가 땅에 위치해있는지 여부
  List<CollisionBlock> collisionBlocks = []; // 충돌 블록

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    debugMode = true;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // 유저 상태 업데이트
    _updatePlayerState();
    // 게임 개발에는 델다 시간을 많이 사용한다.
    _updatePlayerMovement(dt);
    _checkHorizontalCollisions();
    _applyGravity(dt);
    _checkVerticalCollisions();
    super.update(dt); // 많은 프레임을 업데이트 가능하다. 10 프레임은 1초에 10번 업데이트 한다.
    // 정확한 업데이트 량을 정해서 1초마다 일정하게 프레임 업데이트를 시켜준다.
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;
    // a or 물리적으로 왼쪽 화살표
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);

    // d or 물리적으로 오른쪽 화살표
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);

    // 삼항연산자로 왼쪽 오른쪽 이동
    horizontalMovement += isLeftKeyPressed ? -1 : 0;
    horizontalMovement += isRightKeyPressed ? 1 : 0;

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
    velocity.x = horizontalMovement * moveSpeed; // 수평이동이  -1 , 0 , 1  * 100
    // 속도를 플레이어 위치로 설정하면 위치를 호출할 수 있다.
    position.x += velocity.x * dt; // 100 의 이동속도로 움직인다.
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;

    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    // 움직이는 상태면 달리는 상태로 변경
    if (velocity.x > 0 || velocity.x < 0) playerState = PlayerState.running;
    current = playerState;
  }

  // 수평 충돌 확인 메소드
  void _checkHorizontalCollisions() {
    for (final block in collisionBlocks) {
      if (block.isPlatform) {
        //  블록 도트가 플랫폼이 아닌 경우(충돌하는 플랫폼인지 확인)
        if (checkCollision(this, block)) {
          // 충돌을 확인하면 true
          if (velocity.x > 0) {
            // 오른쪽으로 간다면
            velocity.x = 0; // 속도를 0 으로 초기화
            position.x = block.x - width; // 위치 x = 블록 x - 플레이어 넓이에 멈춘다.
            break;
          }
          if (velocity.x < 0) {
            print('왼쪽!');
            velocity.x = 0; // 속도 0 으로 초기화
            position.x =
                block.x + block.width + width; // 위치 x = 블록 x + 플레이어 넓이에 멈춘다.
            break;
          }
        }
      }
    }
  }

  // 중력 적용 메소드
  void _applyGravity(double dt) {
    velocity.y += _gravity; // 중력 더하기
    velocity.y = velocity.y.clamp(-_jumpForce, _terminalVelocity); // 종단 속도보다 더 빨리 안 떨어지게 고정
    position.y += velocity.y * dt;
  }

  // 수직 충돌 확인 메소드
  void _checkVerticalCollisions() {
    for (final block in collisionBlocks) {
      if (block.isPlatform) {  // 블록 플랫폼이라면 실행
      // handle platforms.
      } else { // 블록
        if (checkCollision(this, block)) {
          if (velocity.y > 0) { // 떨어지고 있음
            velocity.y = 0; // 0 으로 초기화
            position.y = block.y - width; // 위치 = 블록 y 에서 높이를 뺀다.
            isOnGround = true;
            break;
          }
          if(velocity.y < 0) {
            velocity.y = 0;
            position.y  = block.y + block.height;
          }
        }
      }
    }
  }
}
