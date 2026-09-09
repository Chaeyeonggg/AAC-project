import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_button.dart';
import '../../main/main_screens/main1_screen.dart';

class PinSettingScreen extends StatefulWidget {
  const PinSettingScreen({super.key});

  @override
  State<PinSettingScreen> createState() => _PinSettingScreenState();
}

class _PinSettingScreenState extends State<PinSettingScreen> {
  String _pin = ''; // 입력된 PIN 번호를 관리하는 변수

  // 번호 패드 터치 시 동작
  void _onKeypadPressed(String value) {
    if (_pin.length < 4) {
      setState(() {
        _pin += value;
      });
    }
  }

  // 백스페이스 처리
  void _onBackspacePressed() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  // 하단 버튼 클릭 시 처리 (완료 여부에 따라 동작이 갈림)
  void _onBottomButtonPressed() {
    if (_pin.length == 4) {
      // TODO: PIN 저장 및 다음 화면 이동 로직 구현
      print("보호자 PIN 설정 최종 완료: $_pin");
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const Main1Screen()));
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isPinComplete = _pin.length == 4;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF0E7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),

              // 1. 상단 자물쇠 이미지 영역
              Image.asset(
                'assets/images/lock.png',
                width: 89.66,
                height: 72.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),

              // 2. 타이틀 및 가이드 텍스트
              Text(
                '보호자 PIN 설정',
                style: AppTypography.pageTitle.copyWith(
                  color: AppColors.DarkText,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '설정 화면에 들어갈 때\n이 PIN을 입력해야 해요',
                textAlign: TextAlign.center,
                style: AppTypography.subText.copyWith(
                  color: AppColors.SubText,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 40),

              // 3. 네모 칸 내부 동그라미 인디케이터
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final bool isInputted = index < _pin.length;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: isInputted
                          ? const Color(0xFFD95E2A)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFE7D5BF),
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: isInputted
                        ? const Icon(
                            Icons.circle,
                            color: Colors.white,
                            size: 20,
                          )
                        : const SizedBox.shrink(),
                  );
                }),
              ),
              const SizedBox(height: 40),

              // 4. 3x4 숫자 가상 키패드 영역
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.17,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  String label = '';
                  Widget? icon;
                  VoidCallback? action;

                  if (index < 9) {
                    label = '${index + 1}';
                    action = () => _onKeypadPressed(label);
                  } else if (index == 9) {
                    return const SizedBox.shrink(); // 왼쪽 하단 공백 처리
                  } else if (index == 10) {
                    label = '0';
                    action = () => _onKeypadPressed(label);
                  } else if (index == 11) {
                    icon = const Icon(
                      Icons.backspace_outlined,
                      color: Color(0xFF2B1A0D),
                      size: 28,
                    );
                    action = _onBackspacePressed;
                  }

                  return InkWell(
                    onTap: action,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFE7D5BF),
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child:
                          icon ??
                          Text(
                            label,
                            style: const TextStyle(
                              color: Color(0xFF2B1A0D),
                              fontSize: 30,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // 5. 조건부 하단 버튼 ("← 이전" ↔ "✅ 설정 완료")
              AppButton(
                text: isPinComplete ? '✅ 설정 완료' : '← 이전',
                onPressed: _onBottomButtonPressed,
                backgroundColor: isPinComplete
                    ? const Color(0xFFD95E2A)
                    : const Color(0xFFE7DFD8),
                textColor: isPinComplete ? Colors.white : AppColors.DarkText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
