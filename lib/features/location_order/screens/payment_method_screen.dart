import 'package:flutter/material.dart';
import '../../../core/services/cart_controller.dart';
import '../../../shared/widgets/option_card.dart';
import '../../../shared/widgets/action_buttons.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/order_summary_bar.dart';
import 'order_confirm_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  final CartController cart;
  final String diningType;

  const PaymentMethodScreen({
    super.key,
    required this.cart,
    required this.diningType,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? _selected; // 'card' | 'cash' | 'easypay'

  void _onSelect(String key) {
    setState(() => _selected = key);
  }

  void _onNext() {
    if (_selected == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OrderConfirmScreen(
          cart: widget.cart,
          diningType: widget.diningType,
          paymentMethod: _selected!,
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
          children: [
            AppHeader(onMenuPressed: () {}),
            OrderSummaryBar(cart: widget.cart),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 32),
                      child: Center(
                        child: Text(
                          '결제는 어떻게?',
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
                      emoji: '💳',
                      label: '카드',
                      selected: _selected == 'card',
                      onTap: () => _onSelect('card'),
                    ),
                    const SizedBox(height: 16),
                    OptionCard(
                      emoji: '💵',
                      label: '현금',
                      selected: _selected == 'cash',
                      onTap: () => _onSelect('cash'),
                    ),
                    const SizedBox(height: 16),
                    OptionCard(
                      emoji: '📱',
                      label: '간편결제',
                      selected: _selected == 'easypay',
                      onTap: () => _onSelect('easypay'),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                children: [
                  PrimaryActionButton(
                    label: '다음 → 주문 완료',
                    enabled: canProceed,
                    onTap: _onNext,
                  ),
                  const SizedBox(height: 12),
                  SecondaryActionButton(label: '← 이전', onTap: _onBack),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
