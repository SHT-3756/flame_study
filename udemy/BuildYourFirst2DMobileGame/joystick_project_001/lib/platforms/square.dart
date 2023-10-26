import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

import 'life_bar.dart';

class Square extends PositionComponent {
  // var velocity = Vector2(0, 25);
  var velocity = Vector2(0, 0).normalized() * 25; // 속도 0;
  var rotationSpeed = 0.3; // 회전 속도
  var squareSize = 128.0; // 큰 사각형 사이즈
  var color = BasicPalette.orange.paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2; // 흰색, 두꺼움 2 의 선
  late LifeBar lifeBar;

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
    lifeBar = LifeBar.initData(size, size: Vector2(size.x - 10, 5), placement: LifeBarPlacement.center);

    add(lifeBar);
  }

  // 충돌
  processHit() {
    lifeBar.decrementCurrentLifeBy(10);
  }
}
