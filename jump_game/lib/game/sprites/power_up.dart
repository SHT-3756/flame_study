import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:jump_game/game/doodle_dash.dart';

abstract class PowerUp extends SpriteComponent with HasGameRef<DoodleDash>, CollisionCallbacks {
  final hitBox = RectangleHitbox();

  double get jumpSpeedMultiplier;

  PowerUp({
    super.position,
  }) : super(size: Vector2.all(50), priority: 2,);

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    await add(hitBox);
  }
}

// Powerups: Add Rocket class

// Powerups: Add NooglerHat class

