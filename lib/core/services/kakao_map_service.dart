import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/kakao_place.dart';

class KakaoMapService {
  static const _baseUrl =
      'https://dapi.kakao.com/v2/local/search/category.json';

  String get _restApiKey => dotenv.env['KAKAO_REST_API_KEY'] ?? '';

  /// 주어진 좌표(경도 x, 위도 y) 근처의 음식점을 거리순으로 검색합니다.
  /// categoryGroupCode 기본값은 'FD6'(음식점). 필요하면 다른 코드로 바꿔 호출하세요.
  /// (예: 'CE7' 카페, 'CS2' 편의점, 'HP8' 병원, 'PM9' 약국)
  Future<List<KakaoPlace>> searchNearbyPlaces({
    required double longitude,
    required double latitude,
    String categoryGroupCode = 'FD6',
    int radiusMeters = 300,
  }) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'category_group_code': categoryGroupCode,
        'x': longitude.toString(),
        'y': latitude.toString(),
        'radius': radiusMeters.toString(),
        'sort': 'distance',
      },
    );

    final response = await http.get(
      uri,
      headers: {'Authorization': 'KakaoAK $_restApiKey'},
    );

    if (response.statusCode != 200) {
      throw Exception('카카오맵 API 호출 실패: ${response.statusCode}');
    }

    final body = jsonDecode(utf8.decode(response.bodyBytes));
    final documents = body['documents'] as List<dynamic>;
    return documents
        .map((doc) => KakaoPlace.fromJson(doc as Map<String, dynamic>))
        .toList();
  }
}
