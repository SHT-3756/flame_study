// 소행성
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../utils.dart';

class Asteroid extends PositionComponent with HasGameRef<ComponentExample001> {
  final vertices = ([
    Vector2(0.2, 0.8), // v1
    Vector2(-0.6, 0.6), // v2
    Vector2(-0.8, 0.2), // v3
    Vector2(-0.6, -0.4), // v4
    Vector2(-0.4, -0.8), // v5
    Vector2(0.0, -1.0), // v6
    Vector2(0.4, -0.6), // v7
    Vector2(0.8, -0.8), // v8
    Vector2(1.0, 0.0), // v9
    Vector2(0.4, 0.2), // v10
    Vector2(0.7, 0.6), // v1
  ]);

  late PolygonComponent asteroid; // 다각형 컴포넌트 타입

  var velocity = Vector2(0, 25);
  var rotationSpeed = 0.3;
  var paint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  @override
  Future<void> onLoad() async {

    asteroid = PolygonComponent(
      vertices, // 소행성을 그릴 Vector2
      size: size, // 소행성 컴포넌트의 실제 사이즈
      position: position, // 위치
      paint: paint,
    );
    print(paint);
    anchor = Anchor.center;
    super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    var angleDelta = dt * rotationSpeed;
    angle = (angle - angleDelta) % (2 * pi);

    if (Utils.isPositionOutOfBounds(gameRef.size, position)) { // 소행성이 외부로 나가면
      gameRef.remove(this); // 게임에서 소행성을 삭제해라
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    asteroid.render(canvas);
  }
}
