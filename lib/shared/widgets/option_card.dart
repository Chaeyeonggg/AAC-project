import 'package:flutter/material.dart';

/// 주문 방식 선택, 결제 수단 선택 등에서 공용으로 쓰는 카드형 옵션 위젯.
class OptionCard extends StatelessWidget {
  final String emoji;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.emoji,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fgColor = selected ? Colors.white : const Color(0xFF2B1A0D);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE74B3C) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE7D5BF), width: 1),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 48)),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: fgColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  height: 1.20,
                ),
              ),
            ),
            if (selected)
              const Text(
                '✅',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
