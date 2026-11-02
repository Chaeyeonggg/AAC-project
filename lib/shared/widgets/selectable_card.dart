import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aac/core/theme/app_colors.dart';

/// 선택 가능한 카드 (공용)
/// 선택 시: 배경색, 테두리색, 테두리 두께가 바뀌고 우상단에 원형 체크가 나타납니다.
class SelectableCard extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final Widget child;

  /// 스크린 리더가 읽을 설명
  final String semanticLabel;

  final double borderRadius;
  final double minHeight;
  final EdgeInsetsGeometry padding;

  // 선택 / 비선택 스타일
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedBorderColor;
  final Color unselectedBorderColor;
  final double selectedBorderWidth;
  final double unselectedBorderWidth;

  const SelectableCard({
    super.key,
    required this.selected,
    required this.onTap,
    required this.child,
    required this.semanticLabel,
    this.borderRadius = 24,
    this.minHeight = 157,
    this.padding = const EdgeInsets.all(20),
    this.selectedColor = AppColors.PreviewBackground,
    this.unselectedColor = AppColors.White,
    this.selectedBorderColor = AppColors.PrimaryDark,
    this.unselectedBorderColor = AppColors.PreviewBorder,
    this.selectedBorderWidth = 4,
    this.unselectedBorderWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    );

    // 테두리 두께가 달라져도 카드 크기가 흔들리지 않도록,
    // 큰 두께 기준으로 패딩을 고정하고 차이만큼 보정합니다.
    final maxBorder = selectedBorderWidth > unselectedBorderWidth
        ? selectedBorderWidth
        : unselectedBorderWidth;
    final currentBorder = selected
        ? selectedBorderWidth
        : unselectedBorderWidth;
    final borderGap = maxBorder - currentBorder;

    return Semantics(
      button: true,
      selected: selected,
      label: semanticLabel,
      excludeSemantics: true,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            color: selected ? selectedColor : unselectedColor,
            shape: shape.copyWith(
              side: BorderSide(
                color: selected ? selectedBorderColor : unselectedBorderColor,
                width: currentBorder,
              ),
            ),
            child: InkWell(
              customBorder: shape,
              onTap: onTap, // 손가락을 뗄 때 실행
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: minHeight),
                child: Padding(
                  // 테두리가 얇아진 만큼 안쪽 여백을 늘려 내용 위치 유지
                  padding: padding.add(EdgeInsets.all(borderGap)),
                  child: child,
                ),
              ),
            ),
          ),

          // 선택 표시 (우상단 원형 체크)
          if (selected)
            Positioned(
              top: -8,
              right: -8,
              child: Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: AppColors.PrimaryDark,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/fill_check.svg',
                    fit: BoxFit.contain,
                    excludeFromSemantics: true,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
