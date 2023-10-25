import 'package:flame/components.dart';
import 'package:flutter/material.dart';

// 총알 클래스는 PositionComponent 이기 때문에 각 위치와 요소를 파악한다.
class Bullet extends PositionComponent {
  // 총알 색상
  static final _paint = Paint()..color = Colors.white;
  // 초당 픽셀당 총알 속도
  final double _speed = 150;
  // 총알의 속도 벡터
  late Vector2 _velocity;

  // 기본 생성자
  Bullet(Vector2 position, Vector2 velocity)
      : _velocity = velocity,
        super(
          position: position,
          size: Vector2.all(4), // 2x2 bullet
          anchor: Anchor.center, // 중심 가운데
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // 속도 백터
    // 속도 벡터는 150 스피드 만큼 이동
    _velocity = (_velocity)..scaleTo(_speed);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void update(double dt) {
    position.add(_velocity * dt);
  }
}
