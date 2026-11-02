import 'package:flutter/material.dart';
import 'package:aac/core/theme/app_colors.dart';
import 'package:aac/shared/widgets/nav_button.dart';
import 'package:aac/shared/widgets/selectable_card.dart';
import 'password_setup_screen.dart';

enum LayoutMode { easy, normal, hard }

class LayoutSelectScreen extends StatefulWidget {
  const LayoutSelectScreen({super.key});

  @override
  State<LayoutSelectScreen> createState() => _LayoutSelectScreenState();
}

class _LayoutSelectScreenState extends State<LayoutSelectScreen> {
  LayoutMode _mode = LayoutMode.easy;

  void _onSelect(LayoutMode mode) {
    setState(() => _mode = mode);
    // TODO: 선택 저장 후 다음 화면(홈)으로 이동
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Primary,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '어떤 화면이 편한가요?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.TextTitle,
                      fontSize: 34,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      height: 1.5,
                      letterSpacing: -0.85,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '나중에 보호자 설정에서 바꿀 수 있어요',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.TextSub,
                      fontSize: 17,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),

                  _LayoutCard(
                    title: '쉬운 화면',
                    description: '한 화면에 메뉴\n2개 골라요',
                    imagePath: 'assets/images/easy_screen.png',
                    selected: _mode == LayoutMode.easy,
                    onTap: () => _onSelect(LayoutMode.easy),
                  ),
                  const SizedBox(height: 20),
                  _LayoutCard(
                    title: '중간 화면',
                    description: '한 화면에 메뉴\n4개 골라요',
                    imagePath: 'assets/images/normal_screen.png',
                    selected: _mode == LayoutMode.normal,
                    onTap: () => _onSelect(LayoutMode.normal),
                  ),
                  const SizedBox(height: 20),
                  _LayoutCard(
                    title: '어려운 화면',
                    description: '한 화면에 메뉴\n여러 개 골라요', // 임시 문구 (확인 필요)
                    imagePath: 'assets/images/hard_screen.png',
                    selected: _mode == LayoutMode.hard,
                    onTap: () => _onSelect(LayoutMode.hard),
                  ),
                  const SizedBox(height: 27.5),

                  NavButton.label(
                    label: '다음→비밀번호 설정',
                    onPressed: () {
                      // TODO: 선택한 _mode 저장 후 비밀번호 설정 화면으로 이동
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const PasswordSetupScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 화면 모드 선택 카드 (이 화면 전용: 이미지 + 문구)
class _LayoutCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool selected;
  final VoidCallback onTap;

  const _LayoutCard({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      selected: selected,
      onTap: onTap,
      semanticLabel: '$title, ${description.replaceAll('\n', ' ')}',
      child: Row(
        children: [
          // 화면 구성 미리보기 이미지 (장식이라 스크린 리더에서 제외)
          Image.asset(
            imagePath,
            width: 150,
            height: 123,
            fit: BoxFit.contain,
            excludeFromSemantics: true,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.TextTitle,
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w800,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.TextSub,
                    fontSize: 17,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.63,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
