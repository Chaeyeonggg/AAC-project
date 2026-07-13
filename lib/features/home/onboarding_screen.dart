import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              // 1. 말풍선 이미지 영역 (이모지 💬 대신 png 자산 사용)
              Center(
                child: Image.asset(
                  'assets/images/speech_bubble.png',
                  width: 112.0,
                  height: 90.0,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 40),

              // 2. 앱 타이틀 (PageTitle 규격 적용)
              Text(
                '말그림 위치톡',
                textAlign: TextAlign.center,
                style: AppTypography.pageTitle.copyWith(
                  color: AppColors.DarkText, // #2B1A0D와 가장 유사한 테마 색상 매핑
                ),
              ),
              const SizedBox(height: 16),

              // 3. 앱 설명 서브 텍스트 영역 (Description 규격 및 정렬 조정)
              Text(
                '장소 기반 맞춤형 AAC\n어디서든 자연스러운 의사소통',
                textAlign: TextAlign.center,
                style: AppTypography.description.copyWith(
                  color: AppColors.SubText, // #8B6A4F와 유사한 서브 텍스트 색상 매핑
                  height: 1.6,
                ),
              ),

              const Spacer(),

              // 4. 시작하기 하단 버튼 (NavButton 규격 적용)
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: SizedBox(
                  width: double.infinity, // 화면 가로를 꽉 채우되 padding 32 준수
                  height: 64, // 피그마 내부 패딩을 감안한 최적의 버튼 높이 확보
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: 시작하기 버튼 클릭 시 로그인(SimpleLoginScreen)으로 이동 로직 구현
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD95E2A), // 디자인 원본 포인트 컬러
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      '시작하기 →',
                      style: AppTypography.navButton.copyWith(
                        color: Colors.white,
                        fontSize: 24, // 버튼 텍스트 디자인 반영
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
