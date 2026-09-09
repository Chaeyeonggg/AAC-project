import 'package:flutter/material.dart';

/// 앱 전반에서 재사용하는 버튼 위젯.
/// width/height를 직접 지정하지 않고, padding으로 버튼 크기를 조절합니다.
/// (padding을 늘리면 버튼이 커지고, 줄이면 작아짐)
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color? disabledBackgroundColor;
  final Color? disabledTextColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double fontSize;
  final Color? borderColor;
  final double borderWidth;
  final String? prefixEmoji;
  final double emojiSize;
  final Widget? leading; // 이모지 대신 커스텀 아이콘(이미지, SVG 등)을 넣고 싶을 때 사용
  final bool isLoading; // true면 텍스트 대신 로딩 스피너 표시

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFFD95E2A),
    this.textColor = Colors.white,
    this.disabledBackgroundColor,
    this.disabledTextColor,
    this.padding = const EdgeInsets.symmetric(vertical: 24),
    this.borderRadius = 16,
    this.fontSize = 24,
    this.borderColor,
    this.borderWidth = 2,
    this.prefixEmoji,
    this.emojiSize = 20,
    this.leading,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;

    return SizedBox(
      width: double.infinity, // 가로는 부모 폭을 채움
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: disabledBackgroundColor ?? backgroundColor,
          foregroundColor: textColor,
          padding: padding, // 세로 크기는 이 padding으로만 결정됨
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: borderWidth)
                : BorderSide.none,
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: textColor,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leading != null) ...[
                    leading!,
                    const SizedBox(width: 12),
                  ] else if (prefixEmoji != null) ...[
                    Text(prefixEmoji!, style: TextStyle(fontSize: emojiSize)),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDisabled
                          ? (disabledTextColor ?? textColor)
                          : textColor,
                      fontSize: fontSize,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
