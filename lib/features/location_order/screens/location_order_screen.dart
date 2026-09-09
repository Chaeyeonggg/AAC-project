import 'package:flutter/material.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../core/theme/app_colors.dart';
import 'store_detecting_screen.dart';

class LocationOrderScreen extends StatelessWidget {
  const LocationOrderScreen({super.key});

  void _onAutoDetectLocation(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const StoreDetectingScreen()),
    );
  }

  void _onCaptureMenu(BuildContext context) {
    // TODO: 카메라 실행 후 메뉴판 촬영 화면으로 이동
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF0E7),
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              onMenuPressed: () {
                // TODO: 설정 화면 이동 (PIN 확인 후 진입)
              },
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. 타이틀
                    const Center(
                      child: Text(
                        '무엇을 도와드릴까요?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF2B1A0D),
                          fontSize: 30,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w800,
                          height: 1.20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 2. 위치 자동 감지 카드
                    _OptionCard(
                      emoji: '📍',
                      title: '위치 자동 감지',
                      description: 'GPS로 장소를 찾아요',
                      onTap: () => _onAutoDetectLocation(context),
                    ),
                    const SizedBox(height: 20),

                    // 3. 메뉴판 촬영 카드
                    _OptionCard(
                      emoji: '📷',
                      title: '메뉴판 촬영',
                      description: '카메라로 메뉴판을 찍어요',
                      onTap: () => _onCaptureMenu(context),
                    ),

                    // raw 코드의 top: 255 여백을 재현 (두 카드와 이전 버튼 사이 큰 간격)
                    const SizedBox(height: 255 - 20),

                    // 4. 이전 버튼
                    AppButton(
                      text: '← 이전',
                      onPressed: () => Navigator.of(context).pop(),
                      backgroundColor: const Color(0xFFE7DFD8),
                      textColor: AppColors.DarkText,
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

/// 장소 주문 화면 전용 선택 카드 (흰 배경 + 테두리 스타일).
class _OptionCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _OptionCard({
    required this.emoji,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 29),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE7D5BF), width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 48)),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF2B1A0D),
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      height: 1.33,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF8B6A4F),
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.56,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
