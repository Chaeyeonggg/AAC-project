import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // 🔥 앞으로 생성될 모든 Scaffold의 기본 배경색을 통일합니다.
      scaffoldBackgroundColor: const Color(0xFFFAF0E7),

      // 💡 추가 팁: 앱 전체의 주요 포인트 색상 테마도 묶어둘 수 있습니다.
      colorScheme: ColorScheme.light(
        primary: AppColors.Primary,
        surface: const Color(0xFFFAF0E7),
      ),
    );
  }
}
