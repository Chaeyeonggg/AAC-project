import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../shared/widgets/mode_card.dart';
import '../../../shared/widgets/app_button.dart';
import 'main2_screen.dart';
import 'package:aac/features/main/sos/sos_screen.dart';
import '../../../shared/widgets/app_header.dart';
import '../../location_order/screens/location_order_screen.dart';

class Main1Screen extends StatelessWidget {
  const Main1Screen({super.key});

  void _onSelectLocationOrder(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LocationOrderScreen()),
    );
  }

  void _onSelectDailyCard(BuildContext context) {
    // TODO: 일상 카드 화면으로 이동
  }

  void _onNextPressed(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const Main2Screen()));
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
                      emoji: '📍',
                      title: '장소 주문',
                      description: 'GPS로 장소를 찾아 주문해요',
                      backgroundColor: const Color(0xFFD95E2A),
                      onTap: () => _onSelectLocationOrder(context),
                    ),
                    const SizedBox(height: 16),

                    ModeCard(
                      emoji: '💬',
                      title: '일상 카드',
                      description: '누르면 소리로 말해줘요',
                      backgroundColor: const Color(0xFF3C9D8B),
                      onTap: () => _onSelectDailyCard(context),
                    ),
                    const SizedBox(height: 16),

                    AppButton(
                      text: '다음 →',
                      onPressed: () => _onNextPressed(context),
                      backgroundColor: const Color(0xFFD95E2A),
                      textColor: Colors.white,
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
