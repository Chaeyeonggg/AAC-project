import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aac/core/theme/app_colors.dart';
import 'package:aac/shared/widgets/nav_button.dart';
import 'layout_select_screen.dart';

class RegisterCompleteScreen extends StatelessWidget {
  const RegisterCompleteScreen({super.key});

  void _onNext(BuildContext context) {
    // TODO: 화면 모드 선택 화면으로 이동
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => LayoutSelectScreen()),
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.RegisterOuterBackground,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Container(
                color: AppColors.RegisterBackground,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
                    child: Column(
                      children: [
                        // 상단 여백 (Figma의 뒤로가기 자리, 높이 36)
                        const SizedBox(height: 36),

                        // 중앙 콘텐츠
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // 체크 아이콘 (원형)
                                  Container(
                                    width: 96,
                                    height: 96,
                                    decoration: const BoxDecoration(
                                      color: AppColors.ChipSelected,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/images/check.svg',
                                        width: 52,
                                        height: 50,
                                        fit: BoxFit.contain,
                                        excludeFromSemantics: true,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 32),

                                  // 제목
                                  const Text(
                                    '등록이 끝났어요',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.TextDark,
                                      fontSize: 33,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w800,
                                      height: 1.25,
                                      letterSpacing: -0.82,
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  // 안내 문구
                                  const Text(
                                    '사례력은 언제든 내 정보 › 사례력에서\n채우거나 고칠 수 있어요.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.TextGray,
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 1.63,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // 다음 버튼 (하단 고정)
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 4),
                          child: SizedBox(
                            width: double.infinity,
                            child: NavButton.next(
                              onPressed: () => _onNext(context),
                            ),
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
    );
  }
}
