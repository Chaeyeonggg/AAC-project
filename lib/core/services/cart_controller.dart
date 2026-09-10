import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/menu_item.dart';

class CartController extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();

  int get totalCount =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  int get totalPrice =>
      _items.values.fold(0, (sum, item) => sum + item.totalPrice);

  int quantityOf(String menuItemId) => _items[menuItemId]?.quantity ?? 0;

  void add(MenuItem menuItem) {
    final existing = _items[menuItem.id];
    _items[menuItem.id] = existing == null
        ? CartItem(menuItem: menuItem, quantity: 1)
        : existing.copyWith(quantity: existing.quantity + 1);
    notifyListeners();
  }

  void remove(MenuItem menuItem) {
    final existing = _items[menuItem.id];
    if (existing == null) return;
    if (existing.quantity <= 1) {
      _items.remove(menuItem.id);
    } else {
      _items[menuItem.id] = existing.copyWith(quantity: existing.quantity - 1);
    }
    notifyListeners();
  }

  /// 팝업에서 수량을 직접 입력/조절한 뒤 "확인"을 눌렀을 때 사용
  void setQuantity(MenuItem menuItem, int quantity) {
    if (quantity <= 0) {
      _items.remove(menuItem.id);
    } else {
      final existing = _items[menuItem.id];
      _items[menuItem.id] = existing == null
          ? CartItem(menuItem: menuItem, quantity: quantity)
          : existing.copyWith(quantity: quantity);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
