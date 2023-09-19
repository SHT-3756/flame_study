import 'package:fit_fighter/constants/globals.dart';
import 'package:fit_fighter/games/fit_fighter.dart';
import 'package:flame/components.dart';

class BackgroundComponent extends SpriteComponent
    with HasGameRef<FitFighterGame> {
  // SpriteComponent 2d 이미지와 애니메이션 사용을 위함


  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite(Global.backgroundSprite);
    size = gameRef.size;
  }
}
