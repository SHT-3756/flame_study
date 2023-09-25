import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:pixel_adventure/levels/level.dart';

// 키 이벤트를 요청 및 사용 가능 하도록 호출(HasKeyboardHandlerComponents)
class PixelAdventure extends FlameGame with HasKeyboardHandlerComponents {

  @override
  Color backgroundColor() => const Color(0XFF211F30);

  late final CameraComponent cam;
  final world = Level(levelName: 'Level-02');

  @override
  FutureOr<void> onLoad() async {
    // 모든 이미지를 캐시해 로드한다.
    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);

    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);

    return super.onLoad();
  }
}
