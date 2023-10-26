import 'package:flame/components.dart';
import 'package:flutter/material.dart';

enum LifeBarPlacement { left, center, right }

class LifeBar extends PositionComponent {
  static const Color _redColor = Colors.red;
  static const Color _greenColor = Colors.green;
  static final Paint _backgroundFillColor = Paint()
    ..color = Colors.grey.withOpacity(0.35)
    ..style = PaintingStyle.fill;
  static final Paint _outlineColor = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  static const int _maxLife = 100; // 최대 체력바
  static const int _healthThreshold = 25; // 건강 임계값 (25 까지는 건강)
  static const double _defaultBarOffset = 2;

  int _life = _maxLife;
  late Paint _color;
  late int _warningThreshold; // 경고 임계값
  late Paint _warningColorStyled;
  late Color _warningColor;
  late Paint _healthyColorStyled;
  late Color _healthyColor;
  late Vector2 _size;
  late Vector2 _parentSize; // 부모 사이즈
  late double _barToParentOffset;
  late LifeBarPlacement _placement; // 체력바 위치
  List<RectangleComponent> _lifeBarElements = List<RectangleComponent>.filled(3, RectangleComponent(size: Vector2(1, 1)), growable: false);

  @override
  Future<void> onLoad() async {
    _lifeBarElements = [
      // 테두리 선
      RectangleComponent(
        position: _calculateBarPosition(),
        size: _size,
        angle: 0,
        paint: _outlineColor,
      ),
      // 배경색
      RectangleComponent(
        position: _calculateBarPosition(),
        size: _size,
        angle: 0,
        paint: _backgroundFillColor,
      ),
      // 체력 (빨강, 초록)
      RectangleComponent(
        position: _calculateBarPosition(),
        size: Vector2(10, _size.y),
        angle: 0,
        paint: _color,
      ),
    ];
    addAll(_lifeBarElements);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updateCurrentColor();
    _lifeBarElements[2].paint = _color;
    _lifeBarElements[2].size.x = (_size.x / _maxLife) * _life;
    super.update(dt);
  }

  // 초기값
  LifeBar.initData(
    Vector2 parentSize, {
    int? warningThreshold,
    Color? warningColor,
    Color? healthyColor,
    Vector2? size,
    double? barOffset,
    LifeBarPlacement? placement,
  }) {
    _warningColor = warningColor ?? _redColor;
    _warningThreshold = warningThreshold ?? _healthThreshold;
    _healthyColor = healthyColor ?? _greenColor;
    _parentSize = parentSize;
    _size = size ?? Vector2(_parentSize.x, 5);
    _barToParentOffset = barOffset ?? _defaultBarOffset;
    _placement = placement ?? LifeBarPlacement.left;

    anchor = Anchor.center;
    _healthyColorStyled = Paint()
      ..color = _healthyColor
      ..style = PaintingStyle.fill;
    _warningColorStyled = Paint()
      ..color = _warningColor
      ..style = PaintingStyle.fill;

    _updateCurrentColor();
  }

  // life 상태 가져오기 0 ~ 100
  int get currentLife {
    return _life;
  }

  // life 저장
  set currentLife(int value) {
    if (value > _maxLife) {
      _life = _maxLife;
    } else if (value < 0) {
      _life = 0;
    } else {
      _life = value;
    }
  }

  // 체력 증가
  void incrementCurrentLifeBy(int incrementValue) {
    currentLife = _life + incrementValue;
  }

  // 체력 감소
  void decrementCurrentLifeBy(int decrementValue) {
    currentLife = _life - decrementValue;
  }

  Color get warningColor {
    return _warningColorStyled.color;
  }

  Color get healthyColor {
    return _healthyColorStyled.color;
  }

  // 현재 색상 업데이트
  void _updateCurrentColor() {
    if (_life < _warningThreshold) {
      // 체력 < 25 보다 낮으면! 빨간색
      _color = _warningColorStyled;
    } else {
      // 체력 > 25 초록색
      _color = _healthyColorStyled;
    }
  }

  // 체력바 위치 계산
  Vector2 _calculateBarPosition() {
    Vector2 result;

    switch (_placement) {
      case LifeBarPlacement.left:
        result = Vector2(0, -_size.y - _barToParentOffset);
        break;
      case LifeBarPlacement.center:
        result = Vector2((_parentSize.x - _size.x) / 2, -_size.y - _barToParentOffset);
        break;
      case LifeBarPlacement.right:
        result = Vector2(_parentSize.x - _size.x, -_size.y - _barToParentOffset);
        break;
      default:
        result = Vector2.zero();
        break;
    }

    return result;
  }
}
