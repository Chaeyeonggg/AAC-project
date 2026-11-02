import 'package:flutter/material.dart';
import 'package:aac/core/theme/app_colors.dart';

enum NavButtonType { prev, next, custom }

/// "이전" / "다음" 공용 버튼 (디자인 동일, 화살표 방향만 다름)
class NavButton extends StatelessWidget {
  final NavButtonType type;

  /// 지정하지 않으면 이전: Navigator.maybePop(), 다음: 아무 동작 없음
  final VoidCallback? onPressed;

  /// custom일 때 표시할 글자 (화살표 아이콘 없음)
  final String? label;

  const NavButton({super.key, required this.type, this.onPressed, this.label});

  const NavButton.prev({super.key, this.onPressed})
    : type = NavButtonType.prev,
      label = null;

  const NavButton.next({super.key, this.onPressed})
    : type = NavButtonType.next,
      label = null;

  /// 글자만 있는 같은 디자인의 버튼 (예: "다음→비밀번호 설정")
  const NavButton.label({super.key, required this.label, this.onPressed})
    : type = NavButtonType.custom;

  bool get _isPrev => type == NavButtonType.prev;
  bool get _isCustom => type == NavButtonType.custom;

  @override
  Widget build(BuildContext context) {
    final text = _isCustom ? label! : (_isPrev ? '이전' : '다음');
    final arrow = Icon(
      _isPrev ? Icons.arrow_back_rounded : Icons.arrow_forward_rounded,
      size: 24,
      color: AppColors.NavButtonText,
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 335),
      child: Material(
        color: AppColors.NavButtonBackground,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.NavButtonBorder, width: 4),
          borderRadius: BorderRadius.circular(22),
        ),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          onTap:
              onPressed ??
              (_isPrev ? () => Navigator.of(context).maybePop() : null),
          child: ConstrainedBox(
            // 고정 높이 대신 최소 높이 (큰 글씨 설정에서도 안 잘림)
            constraints: const BoxConstraints(minHeight: 74),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isPrev) ...[arrow, const SizedBox(width: 12)],
                  Flexible(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.NavButtonText,
                        fontSize: 22,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                  ),
                  if (type == NavButtonType.next) ...[
                    const SizedBox(width: 12),
                    arrow,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
