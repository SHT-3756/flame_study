import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jump_game/game/doodle_dash.dart';

enum PlayerState {
  left,
  right,
  center,
  rocket,
  nooglerCenter,
  nooglerLeft,
  nooglerRight,
}

class Player extends SpriteGroupComponent<PlayerState> with HasGameRef<DoodleDash>, KeyboardHandler, CollisionCallbacks {
  int _hAxisInput = 0;
  final int movingLeftInput = -1;
  final int movingRightInput = 1;
  Vector2 _velocity = Vector2.zero();

  bool get isMovingDown => _velocity.y > 0;
  Character character;
  double jumpSpeed;

  Player({
    super.position,
    required this.character,
    this.jumpSpeed = 600,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Core gameplay: Add circle hitbox to Dash

    // Add a Player to the game: loadCharacterSprites
    // Add a Player to the game: Default Dash onLoad to center state
  }

  @override
  void update(double dt) {
    // Add a Player to the game: Add game state check

    // Add a Player to the game: Add calcualtion for Dash's horizontal velocity
    final double dashHorizontalCenter = size.x / 2;
    // Add a Player to the game: Add infinite side boundaries logic

    // Core gameplay: Add gravity

    // Add a Player to the game: Calculate Dash's current position based on
    // her velocity over elapsed time since last update cycle

    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _hAxisInput = 0;

    // Add a Player to the game: Add keypress logic

    return true;
  }

  void moveLeft() {
    _hAxisInput = 0;
    // Add a Player to the game: Add logic for moving left
  }

  void moveRight() {
    _hAxisInput = 0;
    // Add a Player to the game: Add logic for moving right
  }

  void resetDirection() {
    _hAxisInput = 0;
  }

  // Powerups: Add hasPowerup getter

  // Powerups: Add isInvincible getter

  // Powerups: Add isWearingHat getter

  // Core gameplay: Override onCollision callback

  // Core gameplay: Add a jump method

  // 파워업 시간 후 삭제
  void _removePowerUpAfterTime(int ms) {
    Future.delayed(Duration(milliseconds: ms), () {
      current = PlayerState.center;
    });
  }

  // 점프 스피드 조정
  void setJumpSpeed(double newJumpSpeed) {
    jumpSpeed = newJumpSpeed;
  }

  // 리셋
  void reset() {
    _velocity = Vector2.zero();
    current = PlayerState.center;
  }

  void resetPosition() {
    position = Vector2((gameRef.size.x - size.x) / 2, (gameRef.size.y - size.y) / 2);
  }

  // 캐릭터 순환 로드
  Future<void> _loadCharacterSprites() async {
    final left = await gameRef.loadSprite('game/${character.name}_left.png');
    final right = await gameRef.loadSprite('game/${character.name}_right.png');
    final center =
    await gameRef.loadSprite('game/${character.name}_center.png');
    final rocket = await gameRef.loadSprite('game/rocket_4.png');
    final nooglerCenter =
    await gameRef.loadSprite('game/${character.name}_hat_center.png');
    final nooglerLeft =
    await gameRef.loadSprite('game/${character.name}_hat_left.png');
    final nooglerRight =
    await gameRef.loadSprite('game/${character.name}_hat_right.png');

    sprites = <PlayerState, Sprite>{
      PlayerState.left: left,
      PlayerState.right: right,
      PlayerState.center: center,
      PlayerState.rocket: rocket,
      PlayerState.nooglerLeft: nooglerLeft,
      PlayerState.nooglerRight: nooglerRight,
      PlayerState.nooglerCenter: nooglerCenter,
    };
  }
}
