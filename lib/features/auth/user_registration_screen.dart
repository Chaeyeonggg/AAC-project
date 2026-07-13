import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  // 장애 유형 선택을 위한 변수 (기본값 설정)
  String _selectedDisabilityType = '뇌병변';
  final List<String> _disabilityTypes = ['뇌병변', '언어장애', '발달장애', '기타'];

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),

              // 1. 상단 스마일 이미지 영역 (이모지 😊 대신 smile.png 사용)
              Image.asset(
                'assets/images/smile.png',
                width: 99.61,
                height: 80.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 32),

              // 2. 타이틀 영역
              Text(
                '사용자 등록',
                style: AppTypography.pageTitle.copyWith(
                  color: AppColors.DarkText,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '앱을 사용할 분의 정보예요',
                style: AppTypography.subText.copyWith(color: AppColors.SubText),
              ),
              const SizedBox(height: 40),

              // 3. 사용자 정보 입력 카드 영역
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 이름 입력란
                    Text(
                      '이름',
                      style: AppTypography.description.copyWith(
                        color: AppColors.DarkText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _nameController,
                      decoration: _buildInputDecoration('사용자 이름'),
                    ),
                    const SizedBox(height: 24),

                    // 나이 입력란
                    Text(
                      '나이',
                      style: AppTypography.description.copyWith(
                        color: AppColors.DarkText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number, // 숫자 키보드 배치
                      decoration: _buildInputDecoration('나이'),
                    ),
                    const SizedBox(height: 24),

                    // 장애 유형 선택란 (피그마의 정적 상자를 선택 가능한 Dropdown으로 변환)
                    Text(
                      '장애 유형',
                      style: AppTypography.description.copyWith(
                        color: AppColors.DarkText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 21,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(16),
                        border: BoxBorder.all(
                          color: const Color(0xFFE7D5BF),
                          width: 1,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedDisabilityType,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFFC3A781),
                          ),
                          style: AppTypography.description.copyWith(
                            color: const Color(0xFF374050),
                          ),
                          isExpanded: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              if (newValue != null)
                                _selectedDisabilityType = newValue;
                            });
                          },
                          items: _disabilityTypes.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // 4. 다음 버튼 (PIN 설정으로 이동)
              SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: 입력값 검증 후 다음 PIN 번호 설정 화면으로 이동 로직
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD95E2A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    '다음 → PIN 설정',
                    style: AppTypography.navButton.copyWith(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 5. 이전 버튼
              SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 이전 로그인 화면으로 복귀
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

  // InputDecoration 공통 스타일 헬퍼
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
