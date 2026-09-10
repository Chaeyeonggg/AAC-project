import 'package:dio/dio.dart';
import '../models/store.dart';
import '../models/menu_item.dart';
import '../network/api_client.dart';

class StoreService {
  final Dio _dio = ApiClient.create();

  /// 1) 매장 목록 전체 조회 (GET /stores)
  Future<List<Store>> getStores() async {
    try {
      final response = await _dio.get('/stores');
      final List data = response.data;
      return data.map((json) => Store.fromJson(json)).toList();
    } catch (e) {
      print('매장 목록 조회 실패: $e');
      rethrow;
    }
  }

  /// 2) 특정 매장의 메뉴 목록 조회 (GET /stores/:storeId/menu)
  Future<List<MenuItem>> getMenuItems(int storeId) async {
    try {
      final response = await _dio.get('/stores/$storeId/menu');
      final List data = response.data;
      return data.map((json) => MenuItem.fromJson(json)).toList();
    } catch (e) {
      print('메뉴 목록 조회 실패: $e');
      rethrow;
    }
  }

  /// KakaoPlace 매장 이름 키워드와 매칭되는 백엔드 Store 찾기 (매칭 실패 시 null)
  Future<Store?> findMatchingStore(String placeName) async {
    try {
      final stores = await getStores();
      for (final store in stores) {
        if (placeName.contains(store.name)) {
          return store;
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
