import 'package:flutter/material.dart';

class PrimaryActionButton extends StatelessWidget {
  final String label;
  final bool enabled;
  final VoidCallback onTap;

  const PrimaryActionButton({
    super.key,
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: enabled ? const Color(0xFFE74C3C) : const Color(0x7FE74C3C),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: enabled ? 1.0 : 0.70),
            fontSize: 24,
            fontWeight: FontWeight.w800,
            height: 1.33,
          ),
        ),
      ),
    );
  }
}

class SecondaryActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const SecondaryActionButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFE7DDD0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF2B1A0D),
            fontSize: 24,
            fontWeight: FontWeight.w800,
            height: 1.33,
          ),
        ),
      ),
    );
  }
}
