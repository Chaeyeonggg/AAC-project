import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/services/tts_service.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_header.dart';
import '../main_screens/main1_screen.dart';

class SosScreen extends ConsumerWidget {
  const SosScreen({super.key});

  void _speak(WidgetRef ref, String text) {
    ref.read(ttsServiceProvider).speak(text);
  }

  void _onGoHome(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const Main1Screen()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. 상단 "긴급 도움" 배너
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      decoration: BoxDecoration(
                        color: const Color(0xFFBF382A),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('🆘', style: TextStyle(fontSize: 64)),
                          SizedBox(height: 12),
                          Text(
                            '긴급 도움',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w800,
                              height: 1.11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 2. 도와주세요 카드
                    _SosActionCard(
                      emoji: '🚨',
                      title: '도와주세요!',
                      description: '긴급 상황이에요',
                      onTap: () => _speak(ref, '도와주세요!'),
                    ),
                    const SizedBox(height: 16),

                    // 3. 119 카드
                    _SosActionCard(
                      emoji: '🚑',
                      title: '119 불러주세요!',
                      description: '구급차가 필요해요',
                      onTap: () => _speak(ref, '119 불러주세요!'),
                    ),
                    const SizedBox(height: 16),

                    // 4. 보호자 연락 카드
                    _SosActionCard(
                      emoji: '📞',
                      title: '보호자 연락',
                      description: '보호자에게 연락해주세요',
                      onTap: () => _speak(ref, '보호자에게 연락해주세요'),
                    ),
                    const SizedBox(height: 24),

                    // 5. 처음으로 버튼
                    AppButton(
                      text: '처음으로',
                      onPressed: () => _onGoHome(context),
                      backgroundColor: const Color(0xFFE7DFD8),
                      textColor: AppColors.DarkText,
                      prefixEmoji: '🏠',
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

/// SOS 화면 전용 응급 상황 선택 카드.
/// 카드를 누르면 TTS로 문구를 읽어줍니다.
class _SosActionCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _SosActionCard({
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
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE7A08F), width: 2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 44)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFFBF382A),
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      height: 1.33,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF8B6A4F),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ],
              ),
            ),
            const Text('🔊', style: TextStyle(fontSize: 28)),
          ],
        ),
      ),
    );
  }
}
