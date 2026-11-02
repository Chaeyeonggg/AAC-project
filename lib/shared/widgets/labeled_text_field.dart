import 'package:flutter/material.dart';
import 'package:aac/core/theme/app_colors.dart';

/// 라벨 + 입력창 공용 위젯
/// 기본값은 사용자 등록 화면 스타일이고, 로그인 화면은 [LabeledTextField.login]을 사용합니다.
class LabeledTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final int? maxLength;

  // ───── 스타일 ─────
  final double labelFontSize;
  final FontWeight labelFontWeight;
  final Color labelColor;
  final double labelSpacing;

  final double textFontSize;
  final Color textColor;
  final Color hintColor;

  final Color backgroundColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final double borderRadius;
  final EdgeInsets contentPadding;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.onChanged,
    this.onSubmitted,
    this.maxLength,
    // 사용자 등록 화면 기본값
    this.labelFontSize = 17.5,
    this.labelFontWeight = FontWeight.w800,
    this.labelColor = AppColors.TextDark,
    this.labelSpacing = 10,
    this.textFontSize = 17,
    this.textColor = AppColors.TextDark,
    this.hintColor = AppColors.TextHint,
    this.backgroundColor = AppColors.FieldBackground,
    this.borderColor = AppColors.FieldBorder,
    this.focusedBorderColor = AppColors.ChipSelected,
    this.borderRadius = 14,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 17,
      vertical: 17,
    ),
  });

  /// 로그인 화면 스타일
  const LabeledTextField.login({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.onChanged,
    this.onSubmitted,
    this.maxLength,
  }) : labelFontSize = 20,
       labelFontWeight = FontWeight.w700,
       labelColor = AppColors.TextBrown,
       labelSpacing = 12,
       textFontSize = 18,
       textColor = AppColors.TextBrown,
       hintColor = AppColors.TextHint,
       backgroundColor = AppColors.InputBackground,
       borderColor = AppColors.InputBorder,
       focusedBorderColor = AppColors.PrimaryDark,
       borderRadius = 16,
       contentPadding = const EdgeInsets.symmetric(
         horizontal: 21,
         vertical: 21,
       );

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: color, width: width),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontSize: labelFontSize,
            fontFamily: 'Roboto',
            fontWeight: labelFontWeight,
            height: 1.5,
          ),
        ),
        SizedBox(height: labelSpacing),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          autofillHints: autofillHints,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          maxLength: maxLength,
          style: TextStyle(
            color: textColor,
            fontSize: textFontSize,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: hintColor,
              fontSize: textFontSize,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
            counterText: '', // maxLength 글자 수 표시 숨김
            filled: true,
            fillColor: backgroundColor,
            contentPadding: contentPadding,
            enabledBorder: border(borderColor, 1),
            focusedBorder: border(focusedBorderColor, 2),
          ),
        ),
      ],
    );
  }
}
