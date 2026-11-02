import 'package:aac/features/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aac/core/theme/app_colors.dart';
import 'package:aac/shared/widgets/nav_button.dart';
import '../../main/main_screen.dart';

class PasswordSetupScreen extends StatefulWidget {
  const PasswordSetupScreen({super.key});

  @override
  State<PasswordSetupScreen> createState() => _PasswordSetupScreenState();
}

class _PasswordSetupScreenState extends State<PasswordSetupScreen> {
  static const _length = 4;

  String _pin = '';

  bool get _isComplete => _pin.length == _length;

  void _onDigit(String digit) {
    if (_isComplete) return;
    setState(() => _pin += digit);
  }

  void _onDelete() {
    if (_pin.isEmpty) return;
    setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }

  void _onDone() {
    // TODO: _pin 저장(해시/보안 저장소) 후 다음 화면으로 이동
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const MainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.LoginBackground,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/lock.png',
                      width: 96,
                      height: 96,
                      fit: BoxFit.contain,
                      excludeFromSemantics: true,
                    ),
                  ),
                  const SizedBox(height: 3),
                  // 제목
                  const Text(
                    '보호자 PIN 설정',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.TextBrown,
                      fontSize: 36,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      height: 1.11,
                    ),
                  ),

                  const Text(
                    '설정 화면에 들어갈 때 이 PIN을 입력해야 해요',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.TextBrownSub,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.56,
                    ),
                  ),
                  const SizedBox(height: 28.5),

                  // 4자리 표시
                  Semantics(
                    label: '입력된 비밀번호 ${_pin.length}자리, 총 $_length자리',
                    excludeSemantics: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < _length; i++) ...[
                          if (i > 0) const SizedBox(width: 16),
                          _PinBox(filled: i < _pin.length),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // 숫자 키패드
                  _Keypad(onDigit: _onDigit, onDelete: _onDelete),
                  const SizedBox(height: 24),

                  // 4자리 입력 완료 시 "이전" → "설정 완료"
                  if (_isComplete)
                    _DoneButton(onTap: _onDone)
                  else
                    const NavButton.prev(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 비밀번호 한 칸 (입력 시 초록 배경 + 흰 점)
class _PinBox extends StatelessWidget {
  final bool filled;
  const _PinBox({required this.filled});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: filled ? AppColors.ChipSelected : AppColors.White,
        borderRadius: BorderRadius.circular(16),
        border: filled
            ? null
            : Border.all(color: AppColors.InputBorder, width: 2),
      ),
      child: filled
          ? Center(
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.White,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }
}

/// 숫자 키패드 (1~9, 0, 지우기)
class _Keypad extends StatelessWidget {
  final ValueChanged<String> onDigit;
  final VoidCallback onDelete;

  const _Keypad({required this.onDigit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    Widget row(List<Widget> children) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(width: 12),
            Expanded(child: children[i]),
          ],
        ],
      ),
    );

    Widget digit(String d) => _KeyButton(
      semanticLabel: d,
      onTap: () => onDigit(d),
      child: Text(
        d,
        style: const TextStyle(
          color: AppColors.TextBrown,
          fontSize: 30,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w800,
          height: 1.2,
        ),
      ),
    );

    return Column(
      children: [
        row([digit('1'), digit('2'), digit('3')]),
        row([digit('4'), digit('5'), digit('6')]),
        row([digit('7'), digit('8'), digit('9')]),
        row([
          const SizedBox(), // 빈 칸
          digit('0'),
          _KeyButton(
            semanticLabel: '지우기',
            onTap: onDelete,
            child: SvgPicture.asset(
              'assets/images/backspace.svg',
              width: 31,
              height: 30,
              fit: BoxFit.contain,
              excludeFromSemantics: true,
            ),
          ),
        ]),
      ],
    );
  }
}

/// 키패드 버튼 한 칸
class _KeyButton extends StatelessWidget {
  final Widget child;
  final String semanticLabel;
  final VoidCallback onTap;

  const _KeyButton({
    required this.child,
    required this.semanticLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      excludeSemantics: true,
      child: Material(
        color: AppColors.White,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.InputBorder, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onTap: onTap, // 손가락을 뗄 때 실행
          child: SizedBox(height: 86, child: Center(child: child)),
        ),
      ),
    );
  }
}

/// "설정 완료" 버튼 (이 화면 전용)
class _DoneButton extends StatelessWidget {
  final VoidCallback onTap;
  const _DoneButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.ChipSelected,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 80),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                  child: Text(
                    '✅ 설정 완료',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.White,
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      height: 1.33,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
