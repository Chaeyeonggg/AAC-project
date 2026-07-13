import 'package:flutter/material.dart';

class AppTypography {
  // 기본 디자인 기준 폰트 패밀리 지정
  static const String _fontFamily = 'Pretendard';

  /// PageTitle — 32px / 900 (화면 제목에 사용)
  static const TextStyle pageTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32.0,
    fontWeight: FontWeight.w900, // 900
    height: 1.3, // 줄간격 가독성을 위한 가이드 (필요시 조절)
    letterSpacing: -0.5,
  );

  /// BigChoice Title — 28px / 900 (카드 제목에 사용)
  static const TextStyle bigChoiceTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28.0,
    fontWeight: FontWeight.w900, // 900
    height: 1.3,
    letterSpacing: -0.5,
  );

  /// NavButton — 28px / 900 (다음/이전 버튼)
  static const TextStyle navButton = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28.0,
    fontWeight: FontWeight.w900, // 900
    height: 1.3,
    color: Colors.white, // 버튼 내부 텍스트인 점을 감안해 기본 화이트 지정
  );

  /// SpeakCard — 24px / 900 (일상카드/장소카드 텍스트)
  static const TextStyle speakCard = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24.0,
    fontWeight: FontWeight.w900, // 900
    height: 1.3,
  );

  /// Description — 18px / 600 (카드 설명, 가격)
  static const TextStyle description = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18.0,
    fontWeight: FontWeight.w600, // 600
    height: 1.4,
  );

  /// Sub Text — 16px / 400 (보조 설명)
  static const TextStyle subText = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w400, // 400
    height: 1.4,
  );
}
