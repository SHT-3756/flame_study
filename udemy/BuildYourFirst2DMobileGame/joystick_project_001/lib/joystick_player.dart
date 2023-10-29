import 'package:flame/components.dart';

class JoystickPlayer extends SpriteComponent with HasGameRef {
  // 최고 스피드 픽셀 / 1s
  double maxSpeed = 300.0;

  final JoystickComponent joystick;

  JoystickPlayer(this.joystick)
      : super(
          size: Vector2.all(50.0),
        ) {
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // 배의 이미지를 가져온다.
    sprite = await gameRef.loadSprite('asteroids_ship.png');
    position = gameRef.size / 2; // 화면의 중앙
  }

  @override
  void update(double dt) {
    if (!joystick.delta.isZero()) {
      // 조이스틱이 움직인다면
      position.add(joystick.relativeDelta * maxSpeed * dt);
      angle = (joystick.delta.screenAngle());
    }
  }
}
