import 'package:flutter/material.dart';
import 'package:aac/core/theme/app_colors.dart';

/// 선택 칩 (연령대 / 장애 유형 등 공용)
/// 너비는 부모가 정해줍니다 (Expanded, SizedBox 등).
class SelectChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  /// 최소 높이. 연령대 56, 장애 유형 60
  final double minHeight;

  /// 글자 크기. 연령대 16, 장애 유형 17
  final double fontSize;

  /// 선택됐을 때 글자 앞에 체크 아이콘 표시 (장애 유형용)
  final bool showCheck;

  const SelectChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.minHeight = 56,
    this.fontSize = 16,
    this.showCheck = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? AppColors.White : AppColors.TextDark;

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: Material(
        color: selected ? AppColors.ChipSelected : AppColors.White,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: selected ? AppColors.ChipSelected : AppColors.ChipBorder,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          onTap: onTap, // 손가락을 뗄 때 실행
          child: ConstrainedBox(
            // 고정 높이 대신 최소 높이 (큰 글씨 설정에서도 안 잘림)
            constraints: BoxConstraints(minHeight: minHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (showCheck && selected) ...[
                    Icon(Icons.check_rounded, size: 18, color: textColor),
                    const SizedBox(width: 6),
                  ],
                  Flexible(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 1.5,
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
