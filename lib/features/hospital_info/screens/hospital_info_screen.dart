import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aac/core/theme/app_colors.dart';

class HospitalInfoScreen extends StatelessWidget {
  const HospitalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.HospitalOuterBackground,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          //color: AppColors.Primary,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 28,
              left: 20,
              right: 20,
              bottom: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목
                Text(
                  '병원에서 보여줄 정보',
                  style: const TextStyle(
                    color: AppColors.HospitalTextTitle,
                    fontSize: 26,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w800,
                    height: 1.5,
                    letterSpacing: -0.65,
                  ),
                ),

                const SizedBox(height: 8),

                // 설명
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    '병원 접수처에서 이 정보를 보여 주면\n'
                    '말하지 않아도 필요한 내용이 전달돼요.',
                    style: TextStyle(
                      color: AppColors.HospitalTextSub,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                    ),
                  ),
                ),

                // 설명 아래 간격
                const SizedBox(height: 52.13),

                // 안내 카드
                _buildGuideCard(),
                const SizedBox(height: 73),

                _buildCheckBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGuideCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.White,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          // 첫 번째 안내
          _buildGuideItem(
            iconPath: 'assets/images/cursor.svg',
            title: '대부분 누르기만 하면 돼요',
            subtitle: '글자를 쓸 일은 거의 없어요',
            showBorder: true,
          ),

          // 두 번째 안내
          _buildGuideItem(
            iconPath: 'assets/images/question.svg',
            title: '모르면 ‘몰라요’를 누르세요',
            subtitle: '나중에 알게 되면 채우면 돼요',
            showBorder: true,
          ),

          // 세 번째 안내
          _buildGuideItem(
            iconPath: 'assets/images/pencil.svg',
            title: '언제든 고칠 수 있어요',
            subtitle: '보호자 설정 › 사례력에서 바꿔요',
            showBorder: false,
          ),
        ],
      ),
    );
  }

  Widget _buildGuideItem({
    required String iconPath,
    required String title,
    required String subtitle,
    required bool showBorder,
  }) {
    return Container(
      width: double.infinity,
      height: 77,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: showBorder
            ? const Border(
                bottom: BorderSide(
                  color: AppColors.HospitalCardBorder,
                  width: 1,
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          // 아이콘 배경
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.HospitalIconBackground,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: SvgPicture.asset(iconPath, fit: BoxFit.contain),
            ),
          ),

          const SizedBox(width: 14),

          // 안내 문구
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    color: AppColors.HospitalTextTitle,
                    fontSize: 15.5,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w800,
                    height: 1.38,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    color: AppColors.HospitalTextCaption,
                    fontSize: 13,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 1.38,
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

Widget _buildCheckBox() {
  return Container(
    width: double.infinity,
    height: 74,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.White,
      border: Border.all(color: AppColors.HospitalCheck, width: 2),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Container(
            width: 30,
            height: 30,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors.HospitalCheck,
              border: Border.all(color: AppColors.HospitalCheck, width: 2),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/images/check.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
