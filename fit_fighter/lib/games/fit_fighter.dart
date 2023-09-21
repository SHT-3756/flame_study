import 'dart:async';

import 'package:fit_fighter/components/background_component.dart';
import 'package:flame/game.dart';

class FitFighterGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(BackgroundComponent());
  }
}