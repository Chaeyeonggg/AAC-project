import 'package:flutter/material.dart';
import '../../core/services/cart_controller.dart';

/// 담긴 메뉴 개수와 항목 태그를 보여주는 헤더 바.
/// CartController를 구독해 담긴 항목이 바뀔 때마다 자동 갱신됩니다.
class OrderSummaryBar extends StatelessWidget {
  final CartController cart;

  const OrderSummaryBar({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: cart,
      builder: (context, _) {
        final items = cart.items; // List<CartItem>
        final totalCount = cart.totalCount;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 12,
            left: 16,
            right: 16,
            bottom: 13,
          ),
          decoration: ShapeDecoration(
            color: const Color(0xFFFAF0E7),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFE7D5BF)),
            ),
          ),
          child: SizedBox(
            height: 28,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '🛒 주문 $totalCount개',
                  style: const TextStyle(
                    color: Color(0xFF2B1A0D),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    height: 1.56,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: items.isEmpty
                      ? const SizedBox.shrink()
                      : ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 6),
                          itemBuilder: (context, i) {
                            final cartItem = items[i];
                            return _ItemTag(
                              // 종류가 2개 이상 담겼으면 수량도 같이 보여줌 (예: "치킨버거 x2")
                              label: cartItem.quantity > 1
                                  ? '${cartItem.menuItem.name} x${cartItem.quantity}'
                                  : cartItem.menuItem.name,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ItemTag extends StatelessWidget {
  final String label;

  const _ItemTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFE7D5BF)),
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF2B1A0D),
          fontSize: 12,
          fontWeight: FontWeight.w700,
          height: 1.33,
        ),
      ),
    );
  }
}
