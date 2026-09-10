import 'package:flutter/material.dart';
import '../../../core/services/location_service.dart';
import '../../../core/services/kakao_map_service.dart';
import '../../../core/models/kakao_place.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/app_button.dart';
import 'menu_selection_screen.dart';

/// 감지 상태 (아이콘 색상 / 콘텐츠 분기에 사용)
enum _DetectState { loading, error, success }

/// GPS로 주변 가게를 자동 감지하는 화면.
/// - 로딩 중 / 에러 / 감지 완료(1개 또는 여러 개) 상태에 따라 콘텐츠가 달라짐.
/// - 액션 버튼("카드 불러오기" / "다시 시도" / "이전")은 화면 하단에 고정되어
///   본문을 스크롤해도 항상 보임.
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
  List<KakaoPlace> _detectedStores = [];
  KakaoPlace? _selectedStore;

  @override
  void initState() {
    super.initState();
    _detectStore();
  }

  Future<void> _detectStore() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _detectedStores = [];
      _selectedStore = null;
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
        // KakaoMapService에서 sort=distance로 요청하므로 이미 거리순 정렬됨
        _detectedStores = places;
        _selectedStore = places.first; // 가장 가까운 가게를 기본 선택
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _onSelectStore(KakaoPlace store) {
    setState(() => _selectedStore = store);
  }

  void _onConfirmStore() {
    if (_selectedStore == null) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MenuSelectionScreen(store: _selectedStore!),
      ),
    );
  }

  _DetectState get _state {
    if (_isLoading) return _DetectState.loading;
    if (_errorMessage != null) return _DetectState.error;
    return _DetectState.success;
  }

  /// 상태별 주 액션 버튼 (하단 고정 바에서 사용)
  Widget _buildPrimaryButton() {
    switch (_state) {
      case _DetectState.error:
        return AppButton(
          text: '📍 다시 시도',
          onPressed: _detectStore,
          backgroundColor: const Color(0xFFD95E2A),
          textColor: Colors.white,
        );
      case _DetectState.success:
        return AppButton(
          text: '📍 카드 불러오기',
          onPressed: _selectedStore == null ? null : _onConfirmStore,
          backgroundColor: const Color(0xFFD95E2A),
          textColor: Colors.white,
        );
      case _DetectState.loading:
        return AppButton(
          text: '📍 탐색 중...',
          onPressed: null,
          backgroundColor: const Color(0x99D95E2A),
          textColor: Colors.white,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF0E7),
      // 하단 고정 바가 별도 슬롯이라, body의 SafeArea는 하단을 처리하지 않음
      // (bottomNavigationBar 쪽에서 자체적으로 SafeArea 처리).
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AppHeader(
              onMenuPressed: () {
                // TODO: 설정 화면 이동 (PIN 확인 후 진입)
              },
            ),

            // 본문만 스크롤됨. 가게가 여러 개라 목록이 길어져도
            // 하단 버튼 바는 항상 화면에 고정되어 보임.
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // stretch: 텍스트 박스가 화면 전체 너비를 쓰도록 해서
                  // textAlign.center가 화면 기준으로 정확히 중앙에 오게 함.
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 1. 타이틀 + 부제목
                    const _TitleSection(),
                    const SizedBox(height: 24),

                    // 2. 위치 아이콘 (상태별로 색상이 바뀜: 주황 → 회색 → 초록)
                    Center(child: _LocationPulseIcon(state: _state)),
                    const SizedBox(height: 24),

                    // 3. 상태별 콘텐츠
                    if (_state == _DetectState.loading) ...[
                      const Text(
                        '근처 장소 탐색 중...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFD95E2A),
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 1.56,
                        ),
                      ),
                    ] else if (_state == _DetectState.error) ...[
                      Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ] else ...[
                      if (_detectedStores.length > 1) ...[
                        Text(
                          '총 ${_detectedStores.length}곳을 찾았어요. 원하는 가게를 선택해 주세요',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF8B6A4F),
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      for (int i = 0; i < _detectedStores.length; i++) ...[
                        _StoreOptionCard(
                          store: _detectedStores[i],
                          isSelected:
                              _detectedStores[i].id == _selectedStore?.id,
                          onTap: () => _onSelectStore(_detectedStores[i]),
                        ),
                        if (i != _detectedStores.length - 1)
                          const SizedBox(height: 12),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // 4. 하단 고정 액션 바: 주 액션 버튼 + 이전 버튼.
      // 스크롤 여부와 무관하게 항상 화면 하단에 보임.
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFAF0E7),
            border: Border(
              top: BorderSide(color: const Color(0xFFE7D5BF), width: 1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPrimaryButton(),
              const SizedBox(height: 12),
              AppButton(
                text: '← 이전',
                onPressed: () => Navigator.of(context).pop(),
                backgroundColor: const Color(0xFFE7DFD8),
                textColor: AppColors.DarkText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 타이틀 + 부제목. raw 디자인상 모든 상태에서 동일한 문구를 씀.
class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          '위치 감지',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF2B1A0D),
            fontSize: 30,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w800,
            height: 1.20,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'GPS로 가까운 장소를 찾아요',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF8B6A4F),
            fontSize: 18,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 1.56,
          ),
        ),
      ],
    );
  }
}

/// 배경 원 2겹 + 아이콘.
/// - loading: 주황 톤 + 펄스 애니메이션 + 📍
/// - error: 회색 톤 + ⚠️
/// - success: 초록 톤 + 📍
class _LocationPulseIcon extends StatelessWidget {
  final _DetectState state;

  const _LocationPulseIcon({required this.state});

  @override
  Widget build(BuildContext context) {
    const double outerSize = 260;
    final double innerSize = state == _DetectState.loading ? 189 : 180;

    late final Color outerColor;
    late final Color innerColor;
    late final String emoji;

    switch (state) {
      case _DetectState.loading:
        outerColor = const Color(0x66E9C3B0);
        innerColor = const Color(0xB2D95E2A);
        emoji = '📍';
        break;
      case _DetectState.error:
        outerColor = const Color(0x66BDBDBD);
        innerColor = const Color(0xB29E9E9E);
        emoji = '⚠️';
        break;
      case _DetectState.success:
        outerColor = const Color(0x7FBAF6D0);
        innerColor = const Color(0x994ADE80);
        emoji = '📍';
        break;
    }

    return SizedBox(
      width: outerSize,
      height: outerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: outerSize,
            height: outerSize,
            decoration: BoxDecoration(
              color: outerColor,
              shape: BoxShape.circle,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            width: innerSize,
            height: innerSize,
            decoration: BoxDecoration(
              color: innerColor,
              shape: BoxShape.circle,
            ),
          ),
          Text(emoji, style: const TextStyle(fontSize: 52)),
        ],
      ),
    );
  }
}

/// 감지된 가게 1곳을 나타내는 선택 카드.
/// - 선택됨: ✅ + 초록색 "위치 감지 완료" 라벨 + 진한 테두리
/// - 선택 안 됨: 📍 + 회갈색 "선택하기" 라벨 + 얇은 기본 테두리
/// 탭하면 선택 상태가 바뀜 (가게가 1곳뿐이면 항상 선택된 상태로 보임).
class _StoreOptionCard extends StatelessWidget {
  final KakaoPlace store;
  final bool isSelected;
  final VoidCallback onTap;

  const _StoreOptionCard({
    required this.store,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 21),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: isSelected ? 2 : 1,
              color: isSelected
                  ? const Color(0xFFD95E2A)
                  : const Color(0xFFE7D5BF),
            ),
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(isSelected ? '✅' : '📍', style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isSelected ? '위치 감지 완료' : '선택하기',
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFF16A24A)
                          : const Color(0xFF8B6A4F),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 1.50,
                    ),
                  ),
                  Text(
                    store.placeName,
                    style: const TextStyle(
                      color: Color(0xFF2B1A0D),
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      height: 1.40,
                    ),
                  ),
                  Text(
                    '${store.distanceMeters.round()}m 이내',
                    style: const TextStyle(
                      color: Color(0xFF8B6A4F),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
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
