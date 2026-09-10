class MenuItem {
  final String id;
  final String name;
  final int price; // 원 단위
  final String? imageUrl;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'].toString(),
      name: json['name'] as String,
      price: json['price'] as int,
      imageUrl: json['imageUrl'] as String?,
    );
  }
}
