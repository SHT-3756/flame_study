import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:joystick_project_001/platforms/square.dart';

main() {
  final example = ComponentExample001();
  runApp(
    GameWidget(game: example),
  );
}



class ComponentExample001 extends FlameGame with DoubleTapDetector, TapDetector {
  bool running = true;

  @override
  bool debugMode = false;

//  텍스트 그리기 위함
  final TextPaint textPaint = TextPaint(
    style: const TextStyle(
      fontSize: 14.0,
      fontFamily: 'Awesome Font',
    ),
  );

  @override
  // 한번 탭
  void onTapUp(TapUpInfo info) {
    // 사용자의 탭 위치;
    final touchPoint = info.eventPosition.game;

    // children = flame 엔진에서 모든 컴포넌트를 추적할 수 있다.
    // 하위 컴포넌트에서 우리가 만들어놓은 Square 클래스 이면서 touchPoint 가 포함되어있는 경우!
    // 탭 액션 처리
    // 탭한 위치에 스크린에 도형이 있는 지 여부 체크
    final handled = children.any((component) {
      // 컴포넌트가 사각형이고, 컴포넌트에 내가 클릭한곳이 맞다면
      if (component is Square && component.containsPoint(touchPoint)) {

        // remove(component); // 컴포넌트 삭제
        // 컴포넌트, 이동 속도 역전 => position += -velocity * dt  = 위로 올라간다.
        component.processHit();
        component.velocity.negate();
        return true;
      }
      return false;
    });

    // 새로 도형을 추가해라!
    if (!handled) {
      add(Square()
        ..position = touchPoint // 위치는 터치한 곳으로
        ..squareSize = 45.0 // 크기는 45
        ..velocity = Vector2(0, 1).normalized() * 25 // 하향 백터를 그리고 25 를 곱하면 속도는 25 가 된다.
        ..color = (BasicPalette.red.paint() // 색상은 블로, 선, 두께 2
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2)
      );

      // 운선 소행성 클릭한 곳에 출력
      // add(Asteroid()
      //   ..position = touchPoint
      //   ..size = Vector2(100, 100)
      //   ..velocity = Vector2(0, 1).normalized() * 25
      //   ..paint = (BasicPalette.red.paint()
      //     ..style = PaintingStyle.stroke
      //     ..strokeWidth = 1));

      // (0, 1) 아래로
      // (0, -1) 위로
      // (1, 1) 오른쪽 아래로 대각선
      // (1, -1) 오른쪽 위로 대각선
      // (1, 0) 오른쪽
      // (-1, 0) 왼쪽
      // (-1, 1) 왼쪽 아래 대각선
      // (-1, -1) 오른쪽 위로 대각선
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

  @override
  void render(Canvas canvas) {
    textPaint.render(
      canvas,
      "objects active: ${children.length}",
      Vector2(10, 20),
    );

    super.render(canvas);
  }
}

