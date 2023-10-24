## flame_game_loop_example

처음 만든 플레임 게임 루프 프로젝트 예시

## 코드 
```
void main() {
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
}
```

## 결과
<center><img src="https://github.com/SHT-3756/flame_study/blob/main/udemy/BuildYourFirst2DMobileGame/1/flame_game_loop_example/assets/images/screenshot-1.png" width="400px" height="800px"></center>
