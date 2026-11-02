import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aac/core/theme/app_colors.dart';
import 'package:aac/shared/widgets/nav_button.dart';
import 'package:aac/shared/widgets/select_chip.dart';
import 'register_complete_screen.dart';
import '../../hospital_info/screens/hospital_info_screen.dart';

class CaseHistoryScreen extends StatefulWidget {
  const CaseHistoryScreen({super.key});

  @override
  State<CaseHistoryScreen> createState() => _CaseHistoryScreenState();
}

class _CaseHistoryScreenState extends State<CaseHistoryScreen> {
  static const _yesNoUnknown = ['있어요', '없어요', '몰라요'];
  static const _bloodTypes = ['A', 'B', 'O', 'AB', '몰라요'];

  // 모두 단일 선택, null = 아직 선택 안 함
  String? _allergy;
  String? _medication;
  String? _surgery;
  String? _bloodType;

  void _onNext() {
    // TODO: 사례력 저장 후 "등록이 끝났어요" 화면으로 이동
    // _allergy, _medication, _surgery, _bloodType 사용
    // "지금은 간단히 고르기만 하세요"이므로 미선택도 허용
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const RegisterCompleteScreen()),
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.RegisterOuterBackground,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Container(
                color: AppColors.RegisterBackground,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        const Text(
                          '사례력',
                          style: TextStyle(
                            color: AppColors.TextDark,
                            fontSize: 33,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w800,
                            height: 1.25,
                            letterSpacing: -0.82,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '병원에서 보여줄 정보예요.\n지금은 간단히 고르기만 하세요.',
                          style: TextStyle(
                            color: AppColors.TextGray,
                            fontSize: 16.5,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 1.63,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // 선택 카드
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 24,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.White,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.CardShadow,
                                blurRadius: 12,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ChoiceSection(
                                title: '알레르기',
                                options: _yesNoUnknown,
                                value: _allergy,
                                onChanged: (v) => setState(() => _allergy = v),
                              ),
                              const SizedBox(height: 24),
                              _ChoiceSection(
                                title: '매일 먹는 약',
                                options: _yesNoUnknown,
                                value: _medication,
                                onChanged: (v) =>
                                    setState(() => _medication = v),
                              ),
                              const SizedBox(height: 24),
                              _ChoiceSection(
                                title: '수술한 적',
                                options: _yesNoUnknown,
                                value: _surgery,
                                onChanged: (v) => setState(() => _surgery = v),
                              ),
                              const SizedBox(height: 24),
                              _ChoiceSection(
                                title: '혈액형',
                                options: _bloodTypes,
                                value: _bloodType,
                                onChanged: (v) =>
                                    setState(() => _bloodType = v),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 19.13),

                        // 이전 / 다음
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(child: NavButton.prev()),
                              const SizedBox(width: 12),
                              Expanded(
                                child: NavButton.next(onPressed: _onNext),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 사례력 자세히 입력하기
                        SizedBox(
                          width: double.infinity,
                          child: _DetailInputButton(
                            onTap: () {
                              // TODO: 사례력 상세 입력 화면으로 이동
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (_) => const HospitalInfoScreen(),
                                ),
                                (route) => route.isFirst,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 라벨 + 단일 선택 칩 한 줄
class _ChoiceSection extends StatelessWidget {
  final String title;
  final List<String> options;
  final String? value;
  final ValueChanged<String> onChanged;

  const _ChoiceSection({
    required this.title,
    required this.options,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.TextDark,
            fontSize: 17.5,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w800,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            for (var i = 0; i < options.length; i++) ...[
              if (i > 0) const SizedBox(width: 8),
              Expanded(
                child: SelectChip(
                  label: options[i],
                  selected: value == options[i],
                  onTap: () => onChanged(options[i]),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

/// "사례력 자세히 입력하기" 버튼 (이 화면 전용)
class _DetailInputButton extends StatelessWidget {
  final VoidCallback onTap;

  const _DetailInputButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.White,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.ChipSelected, width: 2),
        borderRadius: BorderRadius.circular(22),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        onTap: onTap, // 손가락을 뗄 때 실행
        child: ConstrainedBox(
          // 고정 높이 대신 최소 높이 (큰 글씨 설정에서도 안 잘림)
          constraints: const BoxConstraints(minHeight: 68),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/clock.svg',
                  width: 32,
                  height: 32,
                  fit: BoxFit.contain,
                  excludeFromSemantics: true,
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    '사례력 자세히 입력하기',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.ChipSelected,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      height: 1.5,
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
