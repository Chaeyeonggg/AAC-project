import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aac/core/theme/app_colors.dart';

/// 긴급 도움 버튼 (길게 눌러야 작동)
class EmergencyButton extends StatefulWidget {
  final VoidCallback onActivated;

  /// 작동에 필요한 누름 시간
  final Duration holdDuration;

  const EmergencyButton({
    super.key,
    required this.onActivated,
    this.holdDuration = const Duration(seconds: 2),
  });

  @override
  State<EmergencyButton> createState() => _EmergencyButtonState();
}

class _EmergencyButtonState extends State<EmergencyButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: widget.holdDuration)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              widget.onActivated();
              _controller.reset(); // 작동 후 초기화
            }
          });
  }

  @override
  void didUpdateWidget(covariant EmergencyButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 보호자 설정에서 누름 시간이 바뀌면 반영
    if (oldWidget.holdDuration != widget.holdDuration) {
      _controller.duration = widget.holdDuration;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _start() => _controller.forward();

  void _cancel() {
    if (_controller.status != AnimationStatus.completed) {
      _controller.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final seconds = widget.holdDuration.inSeconds;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 335),
      child: Semantics(
        button: true,
        label: '긴급 도움, $seconds초 동안 길게 눌러 주세요',
        onLongPress: widget.onActivated, // 스크린 리더 사용자용
        excludeSemantics: true,
        child: Listener(
          onPointerDown: (_) => _start(),
          onPointerUp: (_) => _cancel(),
          onPointerCancel: (_) => _cancel(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: Stack(
              children: [
                // 배경
                Container(
                  constraints: const BoxConstraints(minHeight: 98),
                  color: AppColors.Emergency,
                ),

                // 진행 표시 (누르는 동안 왼쪽에서 오른쪽으로 차오름)
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) => Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: _controller.value,
                        heightFactor: 1,
                        child: Container(color: AppColors.EmergencyProgress),
                      ),
                    ),
                  ),
                ),

                // 내용
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/emergency.svg',
                          width: 23,
                          height: 22,
                          fit: BoxFit.contain,
                          excludeFromSemantics: true,
                        ),
                        const SizedBox(width: 12),
                        const Flexible(
                          child: Text(
                            '긴급 도움 (길게 누르기)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.White,
                              fontSize: 24,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
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
