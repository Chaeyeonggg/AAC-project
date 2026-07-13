import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

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

  @override
  Widget build(BuildContext context) {
    // 4자리 입력이 완료되었는지 여부 확인
    final bool isPinComplete = _pin.length == 4;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),

              // 1. 상단 자물쇠 이미지 영역 (lock.png 활용)
              Image.asset(
                'assets/images/lock.png',
                width: 89.66,
                height: 72.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 32),

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

              // 3. 네모 칸 내부 동그라미 인디케이터 (요청 사항 반영 🛠️)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final bool isInputted = index < _pin.length;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      // 번호가 입력되면 네모 박스 자체가 주황색 포인트 컬러로 변환
                      color: isInputted
                          ? const Color(0xFFD95E2A)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFE7D5BF),
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    // 입력 시 내부에 흰색 동그라미 표출
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

              const Spacer(),

              // 4. 3x4 숫자 가상 키패드 영역 (GridView 압축)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.3,
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
                            style: TextStyle(
                              color: const Color(0xFF2B1A0D),
                              fontSize: 30,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                    ),
                  );
                },
              ),

              const Spacer(),

              // 5. 조건부 하단 다이내믹 버튼 (완료 여부에 따른 전환 처리 🛠️)
              SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  onPressed: isPinComplete
                      ? () {
                          // TODO: PIN 저장 및 메인 홈 화면 진입점 라우팅 처리
                          print("보호자 PIN 설정 최종 완료: $_pin");
                        }
                      : null, // 4자리가 안 되면 비활성화
                  style: ElevatedButton.styleFrom(
                    // 4자리 입력 시 지정하신 주황색(0xFFD95E2A), 미완료 시 회색 계열(0xFFE7DFD8)
                    backgroundColor: isPinComplete
                        ? const Color(0xFFD95E2A)
                        : const Color(0xFFE7DFD8),
                    disabledBackgroundColor: const Color(0xFFE7DFD8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    isPinComplete ? '✅ 설정 완료' : '다음 → PIN 설정',
                    style: AppTypography.navButton.copyWith(
                      color: isPinComplete
                          ? Colors.white
                          : const Color(0xFF2B1A0D),
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
}
