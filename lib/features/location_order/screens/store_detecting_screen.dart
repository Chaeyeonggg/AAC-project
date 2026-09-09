import 'package:flutter/material.dart';
import '../../../core/services/location_service.dart';
import '../../../core/services/kakao_map_service.dart';
import '../../../core/models/kakao_place.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/app_button.dart';
import 'menu_selection_screen.dart';

class StoreDetectingScreen extends StatefulWidget {
  const StoreDetectingScreen({super.key});

  @override
  State<StoreDetectingScreen> createState() => _StoreDetectingScreenState();
}

class _StoreDetectingScreenState extends State<StoreDetectingScreen> {
  final _locationService = LocationService();
  final _kakaoMapService = KakaoMapService();

  bool _isLoading = true;
  String? _errorMessage;
  KakaoPlace? _detectedStore;

  @override
  void initState() {
    super.initState();
    _detectStore();
  }

  Future<void> _detectStore() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final position = await _locationService.getCurrentPosition();
      final places = await _kakaoMapService.searchNearbyPlaces(
        longitude: position.longitude,
        latitude: position.latitude,
      );

      if (places.isEmpty) {
        setState(() {
          _errorMessage = '근처에서 가게를 찾지 못했어요.';
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _detectedStore = places.first; // 거리순 정렬이라 첫 번째가 가장 가까운 가게
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _onConfirmStore() {
    if (_detectedStore == null) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MenuSelectionScreen(store: _detectedStore!),
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
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: _buildContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: Color(0xFFD95E2A)),
          const SizedBox(height: 20),
          Text(
            '주변 가게를 찾고 있어요...',
            style: TextStyle(color: AppColors.SubText, fontSize: 18),
          ),
        ],
      );
    }

    if (_errorMessage != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: '다시 시도',
            onPressed: _detectStore,
            backgroundColor: const Color(0xFFD95E2A),
            textColor: Colors.white,
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('📍', style: TextStyle(fontSize: 48)),
        const SizedBox(height: 16),
        Text(
          _detectedStore!.placeName,
          style: TextStyle(
            color: AppColors.DarkText,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _detectedStore!.roadAddressName.isNotEmpty
              ? _detectedStore!.roadAddressName
              : _detectedStore!.addressName,
          style: TextStyle(color: AppColors.SubText, fontSize: 16),
        ),
        const SizedBox(height: 32),
        AppButton(
          text: '이 가게가 맞아요',
          onPressed: _onConfirmStore,
          backgroundColor: const Color(0xFFD95E2A),
          textColor: Colors.white,
        ),
      ],
    );
  }
}
