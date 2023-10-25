import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';

import 'bullet.dart';
import 'joystick_player.dart';

main() {
  // final example = CaseStudy002Slide002();
  final example = ComponentExample001();
  runApp(
    GameWidget(game: example),
  );
}

class CaseStudy002Slide002 extends FlameGame with HasDraggables, HasTappables {
  static const String description = '''
    In this example we showcase how to use the joystick by creating simple
    `CircleComponent`s that serve as the joystick's knob and background.
    Steer the player by using the joystick. We also show how to shoot bullets
    and how to find the angle of the bullet path relative to the ship's angle
  ''';

  //
  // The player being controlled by Joystick
  late final JoystickPlayer player;

  //
  // The actual Joystick component
  late final JoystickComponent joystick;

  //
  // angle of the ship being displayed on canvas
  final TextPaint shipAngleTextPaint = TextPaint();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    //
    // joystick knob and background skin styles
    final knobPaint = BasicPalette.green.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.green.withAlpha(100).paint();
    //
    // Actual Joystick component creation
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 15, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 20, bottom: 20),
    );

    //
    // adding the player that will be controlled by our joystick
    player = JoystickPlayer(joystick);

    //
    // add both joystick and the controlled player to the game instance
    add(player);
    add(joystick);
  }

  @override
  void update(double dt) {
    //
    //  show the angle of the player
    print("current player angle: ${player.angle}");
    super.update(dt);
  }

  @override
  //
  //
  // We will handle the tap action by the user to shoot a bullet
  // each time the user taps and lifts their finger
  void onTapUp(int pointerId, TapUpInfo info) {
    //
    // velocity vector pointing straight up.
    // Represents 0 radians which is 0 desgrees
    var velocity = Vector2(0, -1);
    // rotate this vector to the same ange as the player
    velocity.rotate(player.angle);
    // create a bullet with the specific angle and add it to the game
    add(Bullet(player.position, velocity));
    super.onTapUp(pointerId, info);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    //
    // render the angle in radians for reference
    shipAngleTextPaint.render(
      canvas,
      '${player.angle.toStringAsFixed(5)} radians',
      Vector2(20, size.y - 24),
    );
  }
}

class Square extends PositionComponent {
  // 속도 0;
  var velocity = Vector2(0, 0).normalized() * 25;

  // 큰 사각형 사이즈
  var squareSize = 128.0;

  // 흰색, 두꺼움 2 의 선
  var color = BasicPalette.white.paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // 초기화
    // 사이즈 가로 128, 세로 128 로 선언
    size.setValues(squareSize, squareSize);
    // 중심 = 오른쪽 위
    anchor = Anchor.topCenter;
  }

  @override
  // 속도에 기반하여 도형의 내부 상태 업데이트
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    // 위치는 속도 * 위치;
    // 속도는 새로고침 빈도에 의존되지 않음
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // 모양 그리기
    canvas.drawRect(size.toRect(), color);
  }
}

class ComponentExample001 extends FlameGame with DoubleTapDetector, TapDetector {
  bool running = true;

  @override
  // 한번 탭
  void onTapUp(TapUpInfo info) {
    // 사용자의 탭 위치;
    final touchPoint = info.eventPosition.game;

    //
    // 탭 액션 처리
    // 탭한 위치에 스크린에 도형이 있는 지 여부 체크
    final handled = children.any((component) {
      // 컴포넌트가 사각형이고, 컴포넌트에 내가 클릭한곳이 맞다면
      if (component is Square && component.containsPoint(touchPoint)) {
        // 컴포넌트 삭제
        // remove(component);
        // 컴포넌트, 이동 속도 역전 => position += -velocity * dt  = 위로 올라간다.
        component.velocity.negate();
        return true;
      }
      return false;
    });

    //
    // 만약에 도형이 없다면
    // 새로 도형을 추가해라!
    if (!handled) {
      add(Square()
        ..position = touchPoint
        ..squareSize = 45.0
        ..velocity = Vector2(0, 1).normalized() * 50
        ..color = (BasicPalette.blue.paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2));
    }
  }

  @override
  // 더블 탭시
  void onDoubleTap() {
    if (running) {
      pauseEngine(); // 엔진 일시정지
    } else {
      resumeEngine(); // 엔진 일시정지 해제
    }
    // 상태 변경
    running = !running;
  }
}
