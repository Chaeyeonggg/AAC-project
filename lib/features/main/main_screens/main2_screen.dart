import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../shared/widgets/mode_card.dart';
import '../../../shared/widgets/app_button.dart';
import 'package:aac/features/main/sos/sos_screen.dart';
import '../../../shared/widgets/app_header.dart';

class Main2Screen extends StatelessWidget {
  const Main2Screen({super.key});

  void _onSelectPlaceManually(BuildContext context) {
    // TODO: 장소 직접 선택 화면(지도/목록)으로 이동
  }

  void _onSelectFavorite(BuildContext context) {
    // TODO: 즐겨찾기 화면으로 이동
  }

  void _onPreviousPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onEmergencyPressed(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const SosScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF0E7),
      body: SafeArea(
        child: Column(
          children: [
            // 상단 헤더 영역
            AppHeader(
              onMenuPressed: () {
                // TODO: 설정 화면 이동 (PIN 확인 후 진입)
              },
            ),

            // 본문 영역
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ModeCard(
                      emoji: '🏠',
                      title: '장소 직접 선택',
                      description: '학교 · 병원 · 약국 · 마트',
                      backgroundColor: const Color(0xFF5B6FBE),
                      onTap: () => _onSelectPlaceManually(context),
                    ),
                    const SizedBox(height: 16),

                    ModeCard(
                      emoji: '⭐',
                      title: '즐겨찾기',
                      description: '지난번 주문 그대로 할게요',
                      backgroundColor: const Color(0xFFE7A02F),
                      onTap: () => _onSelectFavorite(context),
                    ),
                    const SizedBox(height: 16),

                    AppButton(
                      text: '← 이전',
                      onPressed: () => _onPreviousPressed(context),
                      backgroundColor: const Color(0xFFE7DFD8),
                      textColor: AppColors.DarkText,
                    ),
                    const SizedBox(height: 16),

                    AppButton(
                      text: '긴급 도움 요청',
                      onPressed: () => _onEmergencyPressed(context),
                      backgroundColor: Colors.white,
                      textColor: AppColors.DarkText,
                      borderColor: const Color(0xFFE7A08F),
                      fontSize: 20,
                      prefixEmoji: '🆘',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
