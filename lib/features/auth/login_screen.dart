import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 입력값을 제어하기 위한 컨트롤러 등록
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // 입력창 클릭 시 키보드가 올라와도 화면이 깨지지 않도록 스크롤뷰 장착
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),

              // 1. 상단 캐릭터/가족 이미지 영역
              Image.asset(
                'assets/images/people.png',
                width: 99.61,
                height: 80.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 32),

              // 2. 헤더 타이틀 및 서브 텍스트
              Text(
                '보호자 로그인',
                style: AppTypography.pageTitle.copyWith(
                  color: AppColors.DarkText,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '최초 1회만 로그인하면 돼요',
                style: AppTypography.subText.copyWith(color: AppColors.SubText),
              ),
              const SizedBox(height: 40),

              // 3. 소셜 로그인 버튼 영역 (카카오)
              SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: 카카오 로그인 레포지토리 연동
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.Kakao,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/speech_bubble.png',
                        width: 32,
                        height: 32,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '카카오 계정으로 시작',
                        style: AppTypography.navButton.copyWith(
                          color: const Color(0xFF2B1A0D),
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 4. 소셜 로그인 버튼 영역 (네이버)
              SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: 네이버 로그인 레포지토리 연동
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.Naver,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/naver.svg',
                        width: 32,
                        height: 32,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '네이버 계정으로 시작',
                        style: AppTypography.navButton.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // 5. '또는' 구분선 영역
              Row(
                children: [
                  const Expanded(
                    child: Divider(color: Color(0xFFD4B899), thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '또는',
                      style: AppTypography.subText.copyWith(
                        color: AppColors.SubText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: Color(0xFFD4B899), thickness: 1),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 6. 이메일 & 비밀번호 자체 폼 커스텀 카드 영역
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '이메일',
                      style: AppTypography.description.copyWith(
                        color: AppColors.DarkText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _buildInputDecoration('보호자 이메일'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '비밀번호',
                      style: AppTypography.description.copyWith(
                        color: AppColors.DarkText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _passwordController,
                      obscureText: true, // 비밀번호 가리기
                      decoration: _buildInputDecoration('비밀번호'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 7. 이메일로 시작 버튼
              SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: 이메일 로그인 요청 로직 구현
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD95E2A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    '이메일로 시작 →',
                    style: AppTypography.navButton.copyWith(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 8. 이전 버튼
              SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 이전 온보딩 화면으로 빽
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE7DFD8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    '← 이전',
                    style: AppTypography.navButton.copyWith(
                      color: AppColors.DarkText,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 폼 필드 디자인 스타일을 일치시키기 위한 전용 헬퍼 함수
  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Color(0xFFC3A781), fontSize: 18),
      fillColor: const Color(0xFFFAFAFA),
      filled: true,
      contentPadding: const EdgeInsets.all(21),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE7D5BF), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFD95E2A), width: 1.5),
      ),
    );
  }
}
