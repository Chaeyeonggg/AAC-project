import 'package:flutter/material.dart';

/// 홈 화면 등에서 사용하는 카드 선택 위젯.
/// width/height를 직접 지정하지 않고, padding으로 카드 크기를 조절합니다.
/// (padding을 늘리면 카드가 커지고, 줄이면 작아짐)
class ModeCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;
  final Color backgroundColor;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double emojiSize;
  final double titleFontSize;
  final double descriptionFontSize;

  const ModeCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 28, vertical: 76),
    this.borderRadius = 24,
    this.emojiSize = 52,
    this.titleFontSize = 30,
    this.descriptionFontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: double.infinity, // 가로는 부모 폭을 채움 (기존과 동일)
        padding: padding, // 세로 크기는 이 padding으로만 결정됨
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(emoji, style: TextStyle(fontSize: emojiSize)),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: titleFontSize,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.80),
                      fontSize: descriptionFontSize,
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
