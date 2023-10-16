import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:jump_game/game/doodle_dash.dart';

// 게임 상태 enum
enum GameState {intro, playing, gameOver}

class GameManager extends Component with HasGameRef<DoodleDash> {

  // 캐릭터 초기화
  Character character = Character.dash;
  // 상태 병함 감지 변수
  ValueNotifier<int> score = ValueNotifier(0);
  // intro 로 초기화
  GameState state = GameState.intro;

  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;
  bool get isIntro => state == GameState.intro;

  // 초기화 함수
  void reset() {
    score.value= 0;
    state = GameState.intro;
  }

  // 점수 올리기
  void increaseScore() {
    score.value++;
  }

  // 캐릭터 선택
  void selectCharacter(Character selectedCharacter) {
    character = selectedCharacter;
  }
}