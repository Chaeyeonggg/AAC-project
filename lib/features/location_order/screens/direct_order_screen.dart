import 'package:flutter/material.dart';
import '../../../core/models/menu_item.dart';
import '../../../core/services/store_service.dart';
import '../../../core/services/cart_controller.dart';
import 'category_menu_screen.dart';
import '../../../shared/widgets/detected_store_banner.dart';
import '../../../shared/widgets/app_header.dart';

class _CategoryGroup {
  final int? id;
  final String name;
  final List<MenuItem> items;
  const _CategoryGroup({
    required this.id,
    required this.name,
    required this.items,
  });
}

String categoryEmoji(String name) {
  if (name.contains('버거')) return '🍔';
  if (name.contains('사이드')) return '🍟';
  if (name.contains('치킨')) return '🍗';
  if (name.contains('음료')) return '🥤';
  if (name.contains('디저트')) return '🍦';
  return '🍽️';
}

class DirectOrderScreen extends StatefulWidget {
  final int storeId;
  final String storeName;
  final String placeName;

  const DirectOrderScreen({
    super.key,
    required this.storeId,
    required this.storeName,
    required this.placeName,
  });

  @override
  State<DirectOrderScreen> createState() => _DirectOrderScreenState();
}

class _DirectOrderScreenState extends State<DirectOrderScreen> {
  final StoreService _storeService = StoreService();
  final CartController _cart = CartController();

  bool _isLoading = true;
  String? _error;
  List<_CategoryGroup> _groups = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final items = await _storeService.getMenuItems(widget.storeId);

      final Map<int?, List<MenuItem>> byCategory = {};
      for (final item in items) {
        byCategory.putIfAbsent(item.categoryId, () => []).add(item);
      }

      final groups = byCategory.entries
          .where((e) => e.key != null) // 카테고리 없는 메뉴는 목록에서 제외
          .map(
            (e) => _CategoryGroup(
              id: e.key,
              name: e.value.first.categoryName ?? '카테고리',
              items: e.value,
            ),
          )
          .toList();

      if (!mounted) return;
      setState(() {
        _groups = groups;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = '메뉴를 불러오지 못했어요';
        _isLoading = false;
      });
    }
  }

  void _onCategoryTap(_CategoryGroup group) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CategoryMenuScreen(
          categoryName: group.name,
          items: group.items,
          cart: _cart,
        ),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: DetectedStoreBanner(placeName: widget.placeName),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Column(
                children: [
                  Text(
                    '무엇을 주문할까요?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF2B1A0D),
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '카테고리를 골라주세요',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF8B6F59),
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                  ? Center(child: Text(_error!))
                  : _groups.isEmpty
                  ? const Center(child: Text('등록된 카테고리가 없어요'))
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                      itemCount: _groups.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final group = _groups[index];
                        return _CategoryCard(
                          emoji: categoryEmoji(group.name),
                          name: group.name,
                          count: group.items.length,
                          onTap: () => _onCategoryTap(group),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String emoji;
  final String name;
  final int count;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.emoji,
    required this.name,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 21),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE7D5BF)),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF2B1A0D),
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$count개 메뉴',
                  style: const TextStyle(
                    color: Color(0xFF8B6F59),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
