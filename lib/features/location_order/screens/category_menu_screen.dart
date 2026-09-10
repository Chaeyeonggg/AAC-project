import 'package:flutter/material.dart';
import '../../../core/models/menu_item.dart';
import '../../../core/services/cart_controller.dart';
import '../../../shared/widgets/app_header.dart';
import 'direct_order_screen.dart' show categoryEmoji;
import 'order_type_screen.dart';
import '../../../shared/widgets/order_summary_bar.dart';

class CategoryMenuScreen extends StatefulWidget {
  final String categoryName;
  final List<MenuItem> items;
  final CartController cart;

  const CategoryMenuScreen({
    super.key,
    required this.categoryName,
    required this.items,
    required this.cart,
  });

  @override
  State<CategoryMenuScreen> createState() => _CategoryMenuScreenState();
}

class _CategoryMenuScreenState extends State<CategoryMenuScreen> {
  static const int _itemsPerPage = 2;
  int _pageIndex = 0;

  int get _pageCount =>
      (widget.items.length / _itemsPerPage).ceil().clamp(1, 999);

  List<MenuItem> get _currentPageItems {
    final start = _pageIndex * _itemsPerPage;
    if (start >= widget.items.length) return [];
    final end = (start + _itemsPerPage).clamp(0, widget.items.length);
    return widget.items.sublist(start, end);
  }

  String _formatPrice(int price) {
    final s = price.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i != 0 && (s.length - i) % 3 == 0) buffer.write(',');
      buffer.write(s[i]);
    }
    return '$buffer원';
  }

  void _openQuantityPicker(MenuItem item) {
    int tempQty = widget.cart.quantityOf(item.id);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _QtyRoundButton(
                        icon: Icons.remove,
                        onTap: tempQty > 0
                            ? () => setModalState(() => tempQty--)
                            : null,
                      ),
                      SizedBox(
                        width: 56,
                        child: Text(
                          '$tempQty',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      _QtyRoundButton(
                        icon: Icons.add,
                        onTap: () => setModalState(() => tempQty++),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE74B3C),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        widget.cart.setQuantity(item, tempQty);
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        '확인',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _goToOrderType() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OrderTypeScreen(cart: widget.cart),
      ),
    );
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF2B1A0D),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    categoryEmoji(widget.categoryName),
                    style: const TextStyle(fontSize: 28),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.categoryName,
                    style: const TextStyle(
                      color: Color(0xFF2B1A0D),
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: Column(
                  children: [
                    for (final item in _currentPageItems) ...[
                      AnimatedBuilder(
                        animation: widget.cart,
                        builder: (context, _) => _MenuItemCard(
                          item: item,
                          quantity: widget.cart.quantityOf(item.id),
                          priceLabel: _formatPrice(item.price),
                          onTapQuantity: () => _openQuantityPicker(item),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE74B3C),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: const Text(
                    '← 다른 카테고리 보기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: AnimatedBuilder(
                animation: widget.cart,
                builder: (context, _) {
                  final count = widget.cart.totalCount;
                  final active = count > 0;
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: active
                            ? const Color(0xFF4BAF4F)
                            : const Color(0xFFE7DFD8),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: active ? _goToOrderType : null,
                      child: Text(
                        active ? '주문하기 ($count개) →' : '☑️ 선택 완료 (0개) →',
                        style: TextStyle(
                          color: active
                              ? Colors.white
                              : const Color(0xFF8B6F59),
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _PagerCard(
                    label: '← 이전',
                    enabled: _pageIndex > 0,
                    onTap: () => setState(() => _pageIndex--),
                  ),
                  _PagerCard(
                    label: '다음 →',
                    enabled: _pageIndex < _pageCount - 1,
                    onTap: () => setState(() => _pageIndex++),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  Text(
                    '${_pageIndex + 1} / $_pageCount',
                    style: const TextStyle(color: Color(0xFF8B6F59)),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: List.generate(_pageCount, (i) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == _pageIndex
                              ? const Color(0xFFE74B3C)
                              : const Color(0xFFE7D5BF),
                        ),
                      );
                    }),
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

class _MenuItemCard extends StatelessWidget {
  final MenuItem item;
  final int quantity;
  final String priceLabel;
  final VoidCallback onTapQuantity;

  const _MenuItemCard({
    required this.item,
    required this.quantity,
    required this.priceLabel,
    required this.onTapQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE7D5BF)),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFF5ECE3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: item.resolvedImageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      item.resolvedImageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                            child: Text('🍽️', style: TextStyle(fontSize: 28)),
                          ),
                    ),
                  )
                : const Center(
                    child: Text('🍽️', style: TextStyle(fontSize: 28)),
                  ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    color: Color(0xFF2B1A0D),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  priceLabel,
                  style: const TextStyle(
                    color: Color(0xFFE74B3C),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onTapQuantity,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: quantity > 0
                    ? const Color(0xFFE74B3C)
                    : const Color(0xFFE7DFD8),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: quantity > 0
                  ? Text(
                      '$quantity',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyRoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _QtyRoundButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: onTap == null
              ? const Color(0xFFF0F0F0)
              : const Color(0xFFFAF0E7),
        ),
        child: Icon(
          icon,
          color: onTap == null ? Colors.grey : const Color(0xFF2B1A0D),
        ),
      ),
    );
  }
}

class _PagerCard extends StatelessWidget {
  final String label;
  final bool enabled;
  final VoidCallback onTap;

  const _PagerCard({
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 165),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 140,
          height: 80,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: ShapeDecoration(
            color: enabled ? const Color(0xFFE74B3C) : const Color(0xFFE7DDD0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: enabled ? Colors.white : const Color(0xFF8B796A),
              fontSize: 24,
              fontWeight: FontWeight.w800,
              height: 1.33,
            ),
          ),
        ),
      ),
    );
  }
}
