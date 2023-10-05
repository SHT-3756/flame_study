// 플레이어가 충돌 블록 객체에 겹치면 true, false;
bool checkCollision(player, block) {
  final playerX = player.position.x;
  final playerY = player.position.y;
  final playerWidth = player.width;
  final playerHeight = player.height;

  final blockX = block.x;
  final blockY = block.y;
  final blockWidth = block.width;
  final blockHeight = block.height;

  final fixedX = player.scale.x < 0 ? playerX -playerWidth : playerX;

  return (playerY < blockY + blockHeight && // 플레이어 y 위치 < 블록의 y 위치 + 블록 길이
      playerY + playerHeight > blockY && // 플레이어 y 위치 + 플레이어의 길이 > 블록 y 위치
      fixedX < blockX + blockWidth && // 플레이어 x 위치 < 블록 x 위치 + 블록 넓이
      fixedX + playerWidth > blockX); // 플레이어 x 위치 + 플레이어 넓이 > 블록 x 위치
}
