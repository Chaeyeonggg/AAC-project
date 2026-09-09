import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/cart_item.dart';
import '../../../core/services/tts_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/app_button.dart';
import 'payment_method_screen.dart';

class OrderSummaryScreen extends ConsumerWidget {
  final String storeName;
  final List<CartItem> cartItems;
  final PaymentMethod paymentMethod;

  const OrderSummaryScreen({
    super.key,
    required this.storeName,
    required this.cartItems,
    required this.paymentMethod,
  });

  String get _paymentLabel {
    switch (paymentMethod) {
      case PaymentMethod.card:
        return '카드 결제';
      case PaymentMethod.cash:
        return '현금 결제';
      case PaymentMethod.easyPay:
        return '간편 결제';
    }
  }

  int get _totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  String get _summaryText {
    final itemsText = cartItems
        .map((item) => '${item.menuItem.name} ${item.quantity}개')
        .join(', ');
    return '$storeName 에서 $itemsText 주문합니다. 결제 방식은 $_paymentLabel 입니다. 총 금액은 $_totalPrice원 입니다.';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      '주문 확인',
                      style: TextStyle(
                        color: AppColors.DarkText,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(storeName, style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 12),
                    ...cartItems.map(
                      (item) => Text(
                        '${item.menuItem.name} x${item.quantity} — ${item.totalPrice}원',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('결제 방식: $_paymentLabel'),
                    Text(
                      '총 금액: $_totalPrice원',
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: AppButton(
                text: '🔊 읽어주기',
                onPressed: () {
                  ref.read(ttsServiceProvider).speak(_summaryText);
                },
                backgroundColor: const Color(0xFFD95E2A),
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
