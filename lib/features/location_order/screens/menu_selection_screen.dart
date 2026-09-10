import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/kakao_place.dart';
import '../../../core/models/menu_item.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/app_button.dart';
import '../providers/cart_provider.dart';
import 'payment_method_screen.dart';

// TODO: 실제 백엔드 API가 준비되면 이 함수 안쪽만 http 호출로 교체
Future<List<MenuItem>> fetchMenus(String storeId) async {
  await Future.delayed(const Duration(milliseconds: 500)); // 임시 지연
  return [
    MenuItem(id: '1', name: '김치찌개', price: 9000),
    MenuItem(id: '2', name: '된장찌개', price: 8000),
    MenuItem(id: '3', name: '제육볶음', price: 11000),
  ];
}

class MenuSelectionScreen extends ConsumerStatefulWidget {
  final KakaoPlace store;

  const MenuSelectionScreen({super.key, required this.store});

  @override
  ConsumerState<MenuSelectionScreen> createState() =>
      _MenuSelectionScreenState();
}

class _MenuSelectionScreenState extends ConsumerState<MenuSelectionScreen> {
  late Future<List<MenuItem>> _menusFuture;

  @override
  void initState() {
    super.initState();
    _menusFuture = fetchMenus(widget.store.id);
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF0E7),
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(onMenuPressed: () {}),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                widget.store.placeName,
                style: TextStyle(
                  color: AppColors.DarkText,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<MenuItem>>(
                future: _menusFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('메뉴를 불러오지 못했어요: ${snapshot.error}'),
                    );
                  }

                  final menus = snapshot.data!;
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: menus.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final menu = menus[index];
                      final cartItem = cart
                          .where((item) => item.menuItem.id == menu.id)
                          .firstOrNull;

                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE7D5BF)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    menu.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text('${menu.price}원'),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => cartNotifier.decreaseItem(menu),
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text('${cartItem?.quantity ?? 0}'),
                            IconButton(
                              onPressed: () => cartNotifier.addItem(menu),
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: AppButton(
                text: '결제 방식 선택하기 (${cartNotifier.totalPrice}원)',
                onPressed: cart.isEmpty
                    ? null
                    : () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PaymentMethodScreen(
                              storeName: widget.store.placeName,
                            ),
                          ),
                        );
                      },
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
