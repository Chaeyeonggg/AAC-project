import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aac/core/theme/app_colors.dart';
import 'package:aac/features/main/widgets/emergency_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void _onPlaceOrder() {
    // TODO: 장소 주문 화면으로 이동
  }

  void _onDailyCard() {
    // TODO: 일상 카드 화면으로 이동
  }

  void _onFavorites() {
    // TODO: 즐겨찾기 화면으로 이동
  }

  void _onEmergency() {
    // TODO: 긴급 도움 동작 (보호자 연락, 119 안내 등)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Primary,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 48, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '무엇을 할까요?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.TextTitle,
                      fontSize: 32,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      height: 1.5,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // 장소 주문 (큰 가로 카드)
                  _PlaceOrderCard(onTap: _onPlaceOrder),
                  const SizedBox(height: 20),

                  // 일상 카드 / 즐겨찾기 (아치형 카드 2개)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _ArchCard(
                          iconPath: 'assets/images/document.svg',
                          label: '일상 카드',
                          onTap: _onDailyCard,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _ArchCard(
                          iconPath: 'assets/images/favorites.svg',
                          label: '즐겨찾기',
                          onTap: _onFavorites,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 19),
                  EmergencyButton(onActivated: _onEmergency),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// "장소 주문" 큰 카드 (이 화면 전용)
class _PlaceOrderCard extends StatelessWidget {
  final VoidCallback onTap;
  const _PlaceOrderCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      side: const BorderSide(color: AppColors.PrimaryDark, width: 4),
      borderRadius: BorderRadius.circular(30),
    );

    return Semantics(
      button: true,
      label: '장소 주문',
      excludeSemantics: true,
      child: Material(
        color: AppColors.PreviewBackground,
        shape: shape,
        child: InkWell(
          customBorder: shape,
          onTap: onTap, // 손가락을 뗄 때 실행
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 208),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/location.svg',
                    fit: BoxFit.contain,
                    excludeFromSemantics: true,
                  ),
                  const SizedBox(width: 24),
                  const Flexible(
                    child: Text(
                      '장소 주문',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.TextTitle,
                        fontSize: 30,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                        letterSpacing: -0.75,
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

/// 윗부분이 둥근 아치형 카드 (일상 카드, 즐겨찾기)
class _ArchCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onTap;

  const _ArchCard({
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      side: const BorderSide(color: AppColors.PreviewBorder, width: 3),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(120),
        topRight: Radius.circular(120),
        bottomLeft: Radius.circular(22),
        bottomRight: Radius.circular(22),
      ),
    );

    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: Material(
        color: AppColors.White,
        shape: shape,
        child: InkWell(
          customBorder: shape,
          onTap: onTap, // 손가락을 뗄 때 실행
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 324),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(3, 27, 3, 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    iconPath,
                    width: 48,
                    height: 46,
                    fit: BoxFit.contain,
                    excludeFromSemantics: true,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.TextTitle,
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      height: 1.2,
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
