import 'menu_item.dart';

class CartItem {
  final MenuItem menuItem;
  final int quantity;

  CartItem({required this.menuItem, required this.quantity});

  int get totalPrice => menuItem.price * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(menuItem: menuItem, quantity: quantity ?? this.quantity);
  }
}
