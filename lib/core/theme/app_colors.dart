import 'package:flutter/material.dart';

class AppColors {
  // 배경 (연한 민트)
  static const Color Primary = Color(0xFFE8F4EF);

  // 메인 포인트 (딥 틸 그린, 원형 로고 영역)
  static const Color PrimaryDark = Color(0xFF12786A);

  // 로그인 화면 배경
  static const Color LoginBackground = Color(0xFFEAF6F3);

  // 텍스트
  static const Color TextTitle = Color(0xFF17332D);
  static const Color TextSub = Color(0xFF4A6F66);

  // 로그인 화면 텍스트 (브라운 계열)
  static const Color TextBrown = Color(0xFF2B1A0D);
  static const Color TextBrownSub = Color(0xFF8B6A4F);
  static const Color TextHint = Color(0xFFC3A781);

  // 로그인 화면 구분선, 입력창
  static const Color Divider = Color(0xFFD4B899);
  static const Color InputBackground = Color(0xFFFAFAFA);
  static const Color InputBorder = Color(0xFFE7D5BF);

  // 이전/다음 버튼
  static const Color NavButtonBackground = Color(0xFFFBE9A6);
  static const Color NavButtonBorder = Color(0xFFEFC73F);
  static const Color NavButtonText = Color(0xFF3A2D0C);

  static const Color White = Colors.white;

  static const Color Green = Color(0xFF4CAF50);
  static const Color ScanYellow = Color(0xFFFFD600);

  static const Color Kakao = Color(0xFFFEE500);
  static const Color Naver = Color(0xFF03C75A);

  // ───── 사용자 등록 화면 ─────

  // 배경
  static const Color RegisterBackground = Color(0xFFEFF6F2);
  static const Color RegisterOuterBackground = Color(0xFFE6F0EB);

  // 텍스트
  static const Color TextDark = Color(0xFF2B1A12); // 제목, 라벨, 칩 글자
  static const Color TextGray = Color(0xFF5B544F); // 부제 "앱을 쓸 분의 정보를..."
  static const Color TextCaption = Color(0xFF798F87); // "여러 개 선택 가능"

  // 입력창
  static const Color FieldBackground = Color(0xFFFAF4EC);
  static const Color FieldBorder = Color(0xFFEFDBC6);

  // 선택 칩
  static const Color ChipSelected = Color(0xFF3D796A); // 선택 시 배경, 테두리
  static const Color ChipBorder = Color(0xFFE3EDE7); // 비선택 테두리

  // 카드 그림자
  static const Color CardShadow = Color(0x0C17332D);

  // ───── 화면 모드 선택 ─────
  static const Color PreviewBackground = Color(0xFFE6F1EC); // 선택 카드 배경, 미리보기 배경
  static const Color PreviewBorder = Color(0xFFCFE3D9); // 비선택 카드/미리보기 테두리
  static const Color PreviewYellow = Color(0xFFFAE39A); // 미리보기의 노란 막대

  // 긴급 도움 버튼
  static const Color Emergency = Color(0xFFD8413A);
  static const Color EmergencyProgress = Color(
    0xFF9E2A25,
  ); // 긴급 버튼 진행 표시 (더 진한 빨강)

  // ───── 병원 안내 화면 ─────

  // 배경
  static const Color HospitalOuterBackground = Color(0xFFF2F9F5);

  // 텍스트
  static const Color HospitalTextTitle = Color(0xFF16332D);
  static const Color HospitalTextSub = Color(0xFF58796F);
  // 안내 카드
  static const Color HospitalCardBorder = Color(0xFFE9F1EC);
  static const Color HospitalIconBackground = Color(0xFFE3F1E9);
  static const Color HospitalTextCaption = Color(0xFF7C988F);
  // 병원 안내 체크 박스
  static const Color HospitalCheck = Color(0xFF0D6E5D);
}
