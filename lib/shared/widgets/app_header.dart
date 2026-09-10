import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_colors.dart';

/// 앱 상단 공통 헤더 위젯.
/// 좌측에 상태 표시 점 + 타이틀, 우측에 메뉴/설정 아이콘 버튼을 보여줍니다.
/// Scaffold의 body 최상단에 Column의 첫 child로 넣어 사용합니다.
class AppHeader extends StatelessWidget {
  final String title;
  final bool isOnline;
  final VoidCallback? onMenuPressed;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color borderColor;
  final double titleFontSize;
  final double statusDotSize;
  final double menuIconSize;

  const AppHeader({
    super.key,
    this.title = '말그림 위치톡',
    this.isOnline = true,
    this.onMenuPressed,
    this.padding = const EdgeInsets.only(
      top: 16,
      left: 20,
      right: 20,
      bottom: 17,
    ),
    this.backgroundColor = const Color(0xFFFAF0E7),
    this.borderColor = const Color(0xFFE7D5BF),
    this.titleFontSize = 20,
    this.statusDotSize = 12,
    this.menuIconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(bottom: BorderSide(width: 1, color: borderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: statusDotSize,
                height: statusDotSize,
                decoration: BoxDecoration(
                  color: isOnline
                      ? const Color(0xFF22C55E)
                      : const Color(0xFFBDBDBD),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.DarkText,
                  fontSize: titleFontSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                  height: 1.40,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: onMenuPressed,
            icon: SvgPicture.asset(
              'assets/images/menu.svg',
              width: menuIconSize,
              height: menuIconSize,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
          ),
        ],
      ),
    );
  }
}
