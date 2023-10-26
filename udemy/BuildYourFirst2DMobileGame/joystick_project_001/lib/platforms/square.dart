import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Square extends PositionComponent {
  // var velocity = Vector2(0, 25);
  var velocity = Vector2(0, 0).normalized() * 25; // 속도 0;
  var rotationSpeed = 0.3; // 회전 속도
  var squareSize = 128.0; // 큰 사각형 사이즈

  var color = BasicPalette.orange.paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2; // 흰색, 두꺼움 2 의 선

  List<RectangleComponent> lifeBarElements = List<RectangleComponent>.filled(
    3,
    RectangleComponent(size: Vector2(1, 1)),
    growable: false,
  );

  @override
  Future<void> onLoad() async {
    // 초기화
    super.onLoad();
    size.setValues(squareSize, squareSize); // 사이즈 가로 128, 세로 128 로 선언

    anchor = Anchor.center; // 중심 = 오른쪽 위

    createLifeBar();
  }

  @override
  // 속도에 기반하여 도형의 내부 상태 업데이트
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    // 위치 = 속도 * 델타 시간;
    // 프레임 속도와 무관한 새로고침이다. 즉, 프레임 속도에 의존하지 않는다.
    var angleDelta = dt * rotationSpeed; // 회전 속도에 맞게 위치 이동
    angle = (angle + angleDelta) % (2 * pi); // 각도 선언
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // 직사각형 모양 그리기(직사각형 크기, 색상) size 는 onLoad() 에서 size 초기화한 값으로 설정!
    canvas.drawRect(size.toRect(), color);
  }

  // 체력 바 만들기
  createLifeBar() {
    var lifeBarSize = Vector2(40, 10); // 라이프 바를 너비 40, 높이 10 선언
    var backgroundFillColor = Paint()
      ..color = Colors.grey.withOpacity(0.35)
      ..style = PaintingStyle.fill; // 탈락 부분 회색, 불투명도 35%
    var outlineColor = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1; // 외부 테두리 선
    var lifeDangerColor = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill; // 위험! 빨간색

    // 모든 위치는 부모 개체에 연관이 있다.
    lifeBarElements = [
      // 체력바 외부 테두리 선
      RectangleComponent(
        position: Vector2(size.x - lifeBarSize.x, -lifeBarSize.y - 2), // (부모.x(squareSize)  - 체력바.x, 체력바.y - 2)  - 체력바.y : 음수는 위로, -2 : 약간의 공간
        size: lifeBarSize,
        angle: 0,
        paint: outlineColor,
      ),
      // 체력 바 탈락 부분 배경
      RectangleComponent(
        position: Vector2(size.x - lifeBarSize.x, -lifeBarSize.y - 2),
        size: lifeBarSize,
        angle: 0,
        paint: backgroundFillColor,
      ),
      // 실제로 체력바 게이지 (초록, 빨강)
      RectangleComponent(
        position: Vector2(size.x - lifeBarSize.x, -lifeBarSize.y - 2),
        size: Vector2(10, 10),
        angle: 0,
        paint: lifeDangerColor,
      ),
    ];

    // 컴포넌트에 만든 체력바 요소들을 Square 자식들로 추가시켜준다.
    addAll(lifeBarElements);
  }
}