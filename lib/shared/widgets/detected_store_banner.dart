import 'package:flutter/material.dart';

class DetectedStoreBanner extends StatelessWidget {
  final String placeName;
  final String subtitle;

  const DetectedStoreBanner({
    super.key,
    required this.placeName,
    this.subtitle = '위치 자동 감지 완료',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFE74B3C),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Text('📍', style: TextStyle(fontSize: 32)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placeName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.80),
                    fontSize: 14,
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
