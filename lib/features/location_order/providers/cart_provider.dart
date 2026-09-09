import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/cart_item.dart';
import '../../../core/models/menu_item.dart';

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => [];

  void addItem(MenuItem menuItem) {
    final index = state.indexWhere((item) => item.menuItem.id == menuItem.id);
    if (index == -1) {
      state = [...state, CartItem(menuItem: menuItem, quantity: 1)];
    } else {
      final updated = [...state];
      updated[index] = updated[index].copyWith(
        quantity: updated[index].quantity + 1,
      );
      state = updated;
    }
  }

  void decreaseItem(MenuItem menuItem) {
    final index = state.indexWhere((item) => item.menuItem.id == menuItem.id);
    if (index == -1) return;

    final currentQuantity = state[index].quantity;
    if (currentQuantity <= 1) {
      state = state.where((item) => item.menuItem.id != menuItem.id).toList();
    } else {
      final updated = [...state];
      updated[index] = updated[index].copyWith(quantity: currentQuantity - 1);
      state = updated;
    }
  }

  void clear() => state = [];

  int get totalPrice => state.fold(0, (sum, item) => sum + item.totalPrice);
}

final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);
