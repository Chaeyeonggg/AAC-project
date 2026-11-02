import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';
import 'package:aac/shared/widgets/nav_button.dart';
import 'package:aac/shared/widgets/labeled_text_field.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onKakaoTap() {
    // TODO: 카카오 로그인
    // ❣️❣️일단 임의로 다음 화면으로 연결❣️❣️

    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const RegisterScreen()));
  }

  void _onNaverTap() {
    // TODO: 네이버 로그인
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.LoginBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 48),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 제목
                  const Text(
                    '보호자 로그인',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.TextBrown,
                      fontSize: 36,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      height: 1.11,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '처음 한 번만 하면 돼요',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.TextBrownSub,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.56,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 카카오 로그인
                  _SocialButton(
                    color: AppColors.Kakao,
                    textColor: AppColors.TextBrown,
                    label: '카카오 계정으로 시작',
                    icon: Image.asset(
                      'assets/images/speech_bubble.png',
                      width: 32,
                      height: 32,
                      fit: BoxFit.contain,
                      excludeFromSemantics: true,
                    ),
                    onTap: _onKakaoTap,
                  ),
                  const SizedBox(height: 16),

                  // 네이버 로그인
                  _SocialButton(
                    color: AppColors.Naver,
                    textColor: AppColors.White,
                    label: '네이버 계정으로 시작',
                    icon: SvgPicture.asset(
                      'assets/images/naver.svg',
                      width: 32,
                      height: 32,
                      excludeFromSemantics: true,
                    ),
                    onTap: _onNaverTap,
                  ),
                  const SizedBox(height: 32),

                  // 구분선 "또는"
                  Row(
                    children: const [
                      Expanded(child: _DividerLine()),
                      SizedBox(width: 16),
                      Text(
                        '또는',
                        style: TextStyle(
                          color: AppColors.TextBrownSub,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 1.56,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(child: _DividerLine()),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // 이메일 / 비밀번호 카드
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.White,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabeledTextField.login(
                          label: '이메일',
                          hint: '보호자 이메일',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.email],
                        ),
                        const SizedBox(height: 20),
                        LabeledTextField.login(
                          label: '비밀번호',
                          hint: '비밀번호',
                          controller: _passwordController,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.password],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // 이전 버튼
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

/// 카카오/네이버 공통 소셜 로그인 버튼
class _SocialButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String label;
  final Widget icon;
  final VoidCallback onTap;

  const _SocialButton({
    required this.color,
    required this.textColor,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap, // 손가락을 뗄 때 실행
        child: ConstrainedBox(
          // 큰 글씨 설정에서도 잘리지 않도록 최소 높이만 지정
          constraints: const BoxConstraints(minHeight: 80),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
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

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: AppColors.Divider);
  }
}
