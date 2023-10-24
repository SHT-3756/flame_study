import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  // 안드로이드, 아이폰 위의 기본 헤더 앱바를 제거
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(GameWidget(game: MyFirstGame()));
}

class MyFirstGame extends FlameGame with TapDetector {
  @override
  bool get debugMode => true;

  @override
  FutureOr<void> onLoad() {
    add(FpsTextComponent(position : Vector2(10, 50)));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawPaint(Paint()..color = Colors.red.shade200);
    super.render(canvas);
  }

  @override
  void onTapUp(TapUpInfo info) {
    // 턉 위치 출력
    print('tap location x = ${info.eventPosition.game.x}, y = ${info.eventPosition.game.y}');
    super.onTapUp(info);
  }
}
