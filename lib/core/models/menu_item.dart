import '../network/api_client.dart';

class MenuItem {
  final String id;
  final String name;
  final int price;
  final String? imageUrl;
  final int? categoryId;
  final String? categoryName;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
    this.categoryId,
    this.categoryName,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    final categoryJson = json['category'] as Map<String, dynamic>?;
    return MenuItem(
      id: json['id'].toString(),
      name: json['name'] as String,
      price: (json['price'] as num).toInt(),
      imageUrl: json['imageUrl'] as String?,
      categoryId:
          (json['categoryId'] as num?)?.toInt() ??
          (categoryJson?['id'] as num?)?.toInt(),
      categoryName: categoryJson?['name'] as String?,
    );
  }

  /// DB에 상대경로('/images/...')로 저장된 이미지도
  /// 항상 완전한 URL로 변환해서 돌려줌
  String? get resolvedImageUrl {
    final url = imageUrl;
    if (url == null || url.isEmpty) return null;
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }
    final path = url.startsWith('/') ? url : '/$url';
    return '${ApiClient.baseUrl}$path';
  }
}
