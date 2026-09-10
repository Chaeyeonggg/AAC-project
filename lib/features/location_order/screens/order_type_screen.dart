import 'package:flutter/material.dart';
import '../../../core/services/cart_controller.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/order_summary_bar.dart';
import '../../../shared/widgets/option_card.dart';
import '../../../shared/widgets/action_buttons.dart';
import 'payment_method_screen.dart';

class OrderTypeScreen extends StatefulWidget {
  final CartController cart;

  const OrderTypeScreen({super.key, required this.cart});

  @override
  State<OrderTypeScreen> createState() => _OrderTypeScreenState();
}

class _OrderTypeScreenState extends State<OrderTypeScreen> {
  String? _selected; // 'dine_in' | 'takeout'

  void _onSelect(String key) {
    setState(() => _selected = key);
  }

  void _onNext() {
    if (_selected == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaymentMethodScreen(
          cart: widget.cart,
          diningType: _selected!, // 'dine_in' | 'takeout'
        ),
      ),
    );
  }

  void _onBack() {
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final bool canProceed = _selected != null;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF0E7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeader(onMenuPressed: () {}),
            OrderSummaryBar(cart: widget.cart),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 32),
                      child: Center(
                        child: Text(
                          '어디서 드실 건가요?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF2B1A0D),
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                            height: 1.11,
                          ),
                        ),
                      ),
                    ),
                    OptionCard(
                      emoji: '🪑',
                      label: '매장에서 먹기',
                      selected: _selected == 'dine_in',
                      onTap: () => _onSelect('dine_in'),
                    ),
                    const SizedBox(height: 16),
                    OptionCard(
                      emoji: '🛍️',
                      label: '포장하기',
                      selected: _selected == 'takeout',
                      onTap: () => _onSelect('takeout'),
                    ),
                    const Spacer(),
                    PrimaryActionButton(
                      label: '다음 → 결제 수단 선택',
                      enabled: canProceed,
                      onTap: _onNext,
                    ),
                    const SizedBox(height: 12),
                    SecondaryActionButton(label: '← 이전', onTap: _onBack),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
