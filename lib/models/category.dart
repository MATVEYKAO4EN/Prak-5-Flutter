import 'product.dart';
// models/category.dart
class Category {
  final String id;
  String name;
  String icon;
  List<Product> products;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    this.products = const [],
  });

  Category copyWith({
    String? id,
    String? name,
    String? icon,
    List<Product>? products,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      products: products ?? this.products,
    );
  }
}