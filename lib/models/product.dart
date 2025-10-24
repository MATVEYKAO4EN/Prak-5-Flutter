// models/product.dart
class Product {
  final String id;
  String name;
  int quantity;
  int minQuantity;
  String icon;
  String categoryId;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.minQuantity,
    required this.icon,
    required this.categoryId,
  });

  Product copyWith({
    String? id,
    String? name,
    int? quantity,
    int? minQuantity,
    String? icon,
    String? categoryId,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      minQuantity: minQuantity ?? this.minQuantity,
      icon: icon ?? this.icon,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}