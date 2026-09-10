import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/cart_controller.dart';
import '../../../core/services/tts_service.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/order_summary_bar.dart';

class OrderConfirmScreen extends ConsumerStatefulWidget {
  final CartController cart;
  final String diningType; // 'dine_in' | 'takeout'
  final String paymentMethod; // 'card' | 'cash' | 'easypay'

  const OrderConfirmScreen({
    super.key,
    required this.cart,
    required this.diningType,
    required this.paymentMethod,
  });

  @override
  ConsumerState<OrderConfirmScreen> createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends ConsumerState<OrderConfirmScreen> {
  bool _isSpeaking = false;

  static const _diningLabels = {'dine_in': '매장', 'takeout': '포장'};
  static const _diningEmojis = {'dine_in': '🍽️', 'takeout': '🛍️'};
  static const _paymentLabels = {'card': '카드', 'cash': '현금', 'easypay': '간편결제'};
  static const _paymentEmojis = {'card': '💳', 'cash': '💵', 'easypay': '📱'};

  String get _diningLabel => _diningLabels[widget.diningType] ?? '';
  String get _paymentLabel => _paymentLabels[widget.paymentMethod] ?? '';

  String get _itemNamesJoined => widget.cart.items
      .map((c) {
        return c.quantity > 1
            ? '${c.menuItem.name} ${c.quantity}개'
            : c.menuItem.name;
      })
      .join(', ');

  String get _spokenSentence =>
      '$_itemNamesJoined 주세요. $_diningLabel해주세요. 결제는 $_paymentLabel로 할게요.';

  Future<void> _speak() async {
    setState(() => _isSpeaking = true);
    final tts = ref.read(ttsServiceProvider);
    await tts.speak(_spokenSentence);
    if (mounted) setState(() => _isSpeaking = false);
  }

  void _onEdit() => Navigator.of(context).maybePop();

  void _onHome() => Navigator.of(context).popUntil((route) => route.isFirst);

  String _formatPrice(int price) {
    final s = price.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i != 0 && (s.length - i) % 3 == 0) buffer.write(',');
      buffer.write(s[i]);
    }
    return '$buffer원';
  }

  @override
  Widget build(BuildContext context) {
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
                    const Center(
                      child: Text(
                        '이렇게 말할게요',
                        style: TextStyle(
                          color: Color(0xFF2B1A0D),
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          height: 1.11,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 2,
                            color: Color(0xFFE7613A),
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: widget.cart.items.map((c) {
                              final label = c.quantity > 1
                                  ? '${c.menuItem.name} x${c.quantity} ${_formatPrice(c.totalPrice)}'
                                  : '${c.menuItem.name} ${_formatPrice(c.totalPrice)}';
                              return _InfoChip(
                                label: label,
                                bgColor: const Color(0xFFFFF5F0),
                                fgColor: const Color(0xFFE74B3C),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _InfoChip(
                                label:
                                    '${_diningEmojis[widget.diningType]} $_diningLabel하기',
                                bgColor: const Color(0xFFFFF5F0),
                                fgColor: const Color(0xFFE74B3C),
                              ),
                              _InfoChip(
                                label:
                                    '${_paymentEmojis[widget.paymentMethod]} $_paymentLabel',
                                bgColor: const Color(0xFFE7F4FD),
                                fgColor: const Color(0xFF1875D1),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 26,
                            ),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFFF7F5),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 2,
                                  color: Color(0x99E7613A),
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              '🔊 "$_spokenSentence"',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF2B1A0D),
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                height: 1.38,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _isSpeaking ? null : _speak,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE74B3C),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('🔊', style: TextStyle(fontSize: 24)),
                          const SizedBox(width: 12),
                          Text(
                            _isSpeaking ? '말하는 중...' : '크게 말하기',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              height: 1.33,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _onEdit,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7DDD0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '← 수정하기',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF2B1A0D),
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          height: 1.33,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _onHome,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 21),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFFE7D5BF),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        '🏠 처음으로',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF2B1A0D),
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          height: 1.33,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color fgColor;

  const _InfoChip({
    required this.label,
    required this.bgColor,
    required this.fgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: ShapeDecoration(
        color: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fgColor,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          height: 1.56,
        ),
      ),
    );
  }
}
