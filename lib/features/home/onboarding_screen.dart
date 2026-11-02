import 'package:flutter/material.dart';
import 'package:aac/core/theme/app_colors.dart';
import 'package:aac/features/auth/screens/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Primary,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 로고 영역 (원형)
                  Container(
                    width: 160,
                    height: 160,
                    decoration: const BoxDecoration(
                      color: AppColors.PrimaryDark,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/speech_bubble.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                        excludeFromSemantics: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // 앱 이름
                  const Text(
                    '말그림 위치톡',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.TextTitle,
                      fontSize: 38,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      height: 1.5,
                      letterSpacing: -0.95,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 부제
                  const Text(
                    '어디서든 그림으로 말해요',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.TextSub,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 28.7),

                  // 시작하기 버튼
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 375),
                    child: SizedBox(
                      width: double.infinity,
                      height: 85,
                      child: Material(
                        color: AppColors.PrimaryDark,
                        shape: const StadiumBorder(),
                        child: InkWell(
                          customBorder: const StadiumBorder(),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '시작하기',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.White,
                                    fontSize: 27,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  '→',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.White,
                                    fontSize: 32,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w800,
                                    height: -0.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
