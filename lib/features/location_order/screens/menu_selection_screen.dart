import 'package:flutter/material.dart';
import '../../../core/models/kakao_place.dart';
import '../../../core/models/store.dart';
import '../../../core/services/store_service.dart';
import 'direct_order_screen.dart';
import '../../../shared/widgets/detected_store_banner.dart';

class MenuSelectionScreen extends StatefulWidget {
  final KakaoPlace store;

  const MenuSelectionScreen({super.key, required this.store});

  @override
  State<MenuSelectionScreen> createState() => _MenuSelectionScreenState();
}

class _MenuSelectionScreenState extends State<MenuSelectionScreen> {
  final StoreService _storeService = StoreService();
  Store? _backendStore;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBackendStore();
  }

  /// 카카오 장소명으로 백엔드 Store 매칭
  Future<void> _fetchBackendStore() async {
    final matched = await _storeService.findMatchingStore(
      widget.store.placeName,
    );
    if (mounted) {
      setState(() {
        _backendStore = matched;
        _isLoading = false;
      });
    }
  }

  _BrandInfo _detectBrand() {
    final name = widget.store.placeName;
    if (name.contains('롯데리아')) {
      return const _BrandInfo(emoji: '🍔', label: '롯데리아');
    }
    if (name.contains('맥도날드')) {
      return const _BrandInfo(emoji: '🍟', label: '맥도날드');
    }
    if (name.contains('시올돈')) {
      return const _BrandInfo(emoji: '🍱', label: '시올돈');
    }
    return const _BrandInfo(emoji: '🏬', label: '매장');
  }

  void _onDirectOrder(BuildContext context) {
    if (_backendStore == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('지원되지 않거나 등록되지 않은 매장입니다.')));
      return;
    }

    final brand = _detectBrand();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DirectOrderScreen(
          storeId: _backendStore!.id,
          storeName: _backendStore!.name,
          placeName: widget.store.placeName,
        ),
      ),
    );
  }

  void _onBrowseMenu(BuildContext context) {
    // TODO: BrowseMenuScreen 구현 시 연결
  }

  @override
  Widget build(BuildContext context) {
    final brand = _detectBrand();

    return Scaffold(
      backgroundColor: const Color(0xFFFAF5F0),
      body: SafeArea(
        child: Column(
          children: [
            _MenuSelectionHeader(brand: brand),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DetectedStoreBanner(placeName: widget.store.placeName),
                    const SizedBox(height: 32),
                    const Text(
                      '어떻게 주문할까요?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF3C2A1F),
                        fontSize: 40,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w800,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (_isLoading)
                      const Center(child: CircularProgressIndicator())
                    else ...[
                      _OrderOptionCard(
                        emoji: '⚡',
                        title: '바로 주문',
                        description: '메뉴 고르면 바로 주문해요',
                        onTap: () => _onDirectOrder(context),
                      ),
                      const SizedBox(height: 16),
                      _OrderOptionCard(
                        emoji: '❤️',
                        title: '구경하고 고르기',
                        description: '찜해두고 나중에 골라요',
                        onTap: () => _onBrowseMenu(context),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandInfo {
  final String emoji;
  final String label;
  const _BrandInfo({required this.emoji, required this.label});
}

class _MenuSelectionHeader extends StatelessWidget {
  final _BrandInfo brand;

  const _MenuSelectionHeader({required this.brand});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 17),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xFFE7DFD5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFF4BAF4F),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '말그림 위치톡',
                style: TextStyle(
                  color: Color(0xFF3C2A1F),
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE7613A),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(brand.emoji, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 6),
                Text(
                  brand.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderOptionCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _OrderOptionCard({
    required this.emoji,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE7D5BF), width: 1),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 48)),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF3C2A1F),
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF8B6F59),
                      fontSize: 18,
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
