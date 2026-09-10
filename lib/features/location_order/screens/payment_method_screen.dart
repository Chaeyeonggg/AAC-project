import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/app_button.dart';
import '../providers/cart_provider.dart';
import 'order_summary_screen.dart';

enum PaymentMethod { card, cash, easyPay }

class PaymentMethodScreen extends ConsumerStatefulWidget {
  final String storeName;

  const PaymentMethodScreen({super.key, required this.storeName});

  @override
  ConsumerState<PaymentMethodScreen> createState() =>
      _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends ConsumerState<PaymentMethodScreen> {
  PaymentMethod? _selected;

  void _onConfirm() {
    if (_selected == null) return;
    final cart = ref.read(cartProvider);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OrderSummaryScreen(
          storeName: widget.storeName,
          cartItems: cart,
          paymentMethod: _selected!,
        ),
      ),
    );
  }

  String _label(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.card:
        return '카드 결제';
      case PaymentMethod.cash:
        return '현금 결제';
      case PaymentMethod.easyPay:
        return '간편 결제';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF0E7),
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(onMenuPressed: () {}),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '결제 방식을 선택해주세요',
                      style: TextStyle(
                        color: AppColors.DarkText,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...PaymentMethod.values.map((method) {
                      final isSelected = _selected == method;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () => setState(() => _selected = method),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFD95E2A)
                                    : const Color(0xFFE7D5BF),
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Text(
                              _label(method),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: AppButton(
                text: '주문 확인하기',
                onPressed: _selected == null ? null : _onConfirm,
                backgroundColor: const Color(0xFFD95E2A),
                textColor: Colors.white,
                disabledBackgroundColor: const Color(0xFFE7DFD8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
