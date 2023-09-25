import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/actors/player.dart';
import 'package:pixel_adventure/levels/level.dart';

// 키 이벤트를 요청 및 사용 가능 하도록 호출(HasKeyboardHandlerComponents)
// 조이스틱 드래그 사용하기 위함 (DragCallbacks)
class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => const Color(0XFF211F30);
  late final CameraComponent cam;
  Player player = Player();
  late JoystickComponent joystick;
  bool showJoystick = true; // desktop 인 경우 false 로 설정 플랫폼 설정

  @override
  FutureOr<void> onLoad() async {
    // 모든 이미지를 캐시해 로드한다.
    await images.loadAllImages();

    final world = Level(
      player: player,
      levelName: 'Level-02',
    );

    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);

    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);

    if (showJoystick) {
      addJoystick();
    }
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showJoystick) {
      updateJoystick();
    }
    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      knobRadius: 64, // 노브 반경 늘이기 (없으면 이미지를 정확하게 움직여야 함, 필수 아님)
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache(
            'HUD/Joystick.png',
          ),
        ),
      ),
      // 필수로 위치 잡아줘야함
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );
    // 게임에 추가
    add(joystick);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.playerDirection = PlayerDirection.left;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.playerDirection = PlayerDirection.right;
        break;

      default:
        player.playerDirection = PlayerDirection.none;
        // idle
        break;
    }
  }
}
