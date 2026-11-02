import 'package:flutter/material.dart';
import 'package:aac/core/theme/app_colors.dart';
import 'package:aac/shared/widgets/labeled_text_field.dart';
import 'package:aac/shared/widgets/nav_button.dart';
import 'package:aac/shared/widgets/select_chip.dart';
import 'case_history_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const _ages = ['어린이', '청소년', '성인', '어르신'];
  static const _noneLabel = '선택 안 함';
  static const _disabilityTypes = ['뇌병변', '지적', '자폐성', '언어', '청각', _noneLabel];

  final _nameController = TextEditingController();
  String? _age; // 단일 선택
  final Set<String> _types = {}; // 다중 선택

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _toggleType(String type) {
    setState(() {
      if (_types.contains(type)) {
        _types.remove(type);
        return;
      }
      if (type == _noneLabel) {
        // "선택 안 함"을 누르면 나머지 해제
        _types
          ..clear()
          ..add(_noneLabel);
      } else {
        // 다른 유형을 누르면 "선택 안 함" 해제
        _types
          ..remove(_noneLabel)
          ..add(type);
      }
    });
  }

  void _onNext() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      _showMessage('이름을 입력해 주세요');
      return;
    }
    if (_age == null) {
      _showMessage('연령대를 선택해 주세요');
      return;
    }

    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const CaseHistoryScreen()));
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
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
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),

                        // 제목
                        const Text(
                          '사용자 등록',
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
                          '앱을 쓸 분의 정보를 입력해 주세요',
                          style: TextStyle(
                            color: AppColors.TextGray,
                            fontSize: 16.5,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // 입력 카드
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
                              // 이름
                              LabeledTextField(
                                label: '이름',
                                hint: '사용자 이름',
                                controller: _nameController,
                                textInputAction: TextInputAction.done,
                                maxLength: 20,
                              ),
                              const SizedBox(height: 24),

                              // 연령대
                              const _SectionLabel('연령대'),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  for (var i = 0; i < _ages.length; i++) ...[
                                    if (i > 0) const SizedBox(width: 8),
                                    Expanded(
                                      child: SelectChip(
                                        label: _ages[i],
                                        selected: _age == _ages[i],
                                        onTap: () =>
                                            setState(() => _age = _ages[i]),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 24),

                              // 장애 유형
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  _SectionLabel('장애 유형'),
                                  SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      '여러 개 선택 가능',
                                      style: TextStyle(
                                        color: AppColors.TextCaption,
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final chipWidth =
                                      (constraints.maxWidth - 10) / 2;
                                  return Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      for (final type in _disabilityTypes)
                                        SizedBox(
                                          width: chipWidth,
                                          child: SelectChip(
                                            label: type,
                                            selected: _types.contains(type),
                                            minHeight: 60,
                                            fontSize: 17,
                                            showCheck: true,
                                            onTap: () => _toggleType(type),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 55.25),

                        // 이전 / 다음
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
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

/// 카드 안 섹션 라벨 ("연령대", "장애 유형")
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.TextDark,
        fontSize: 17.5,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w800,
        height: 1.5,
      ),
    );
  }
}
