/// 카카오 로컬 API의 장소 검색 결과 1건을 표현하는 모델.
class KakaoPlace {
  final String id;
  final String placeName;
  final String categoryName;
  final String addressName;
  final String roadAddressName;
  final double x; // 경도
  final double y; // 위도
  final double distanceMeters;

  KakaoPlace({
    required this.id,
    required this.placeName,
    required this.categoryName,
    required this.addressName,
    required this.roadAddressName,
    required this.x,
    required this.y,
    required this.distanceMeters,
  });

  factory KakaoPlace.fromJson(Map<String, dynamic> json) {
    return KakaoPlace(
      id: json['id'] as String,
      placeName: json['place_name'] as String,
      categoryName: json['category_name'] as String? ?? '',
      addressName: json['address_name'] as String? ?? '',
      roadAddressName: json['road_address_name'] as String? ?? '',
      x: double.tryParse(json['x'] as String? ?? '') ?? 0,
      y: double.tryParse(json['y'] as String? ?? '') ?? 0,
      distanceMeters: double.tryParse(json['distance'] as String? ?? '') ?? 0,
    );
  }
}
