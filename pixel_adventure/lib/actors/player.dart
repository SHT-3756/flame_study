import 'dart:async';

import 'package:flame/components.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

enum PlayerState { idle, running }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure> {
  String character;

  Player({position, required this.character}): super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();

    return super.onLoad();
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
    current = PlayerState.running;
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
}
