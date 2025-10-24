// screens/products_screen.dart
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../widgets/productCard.dart';
import '../widgets/addProductDialog.dart';

class ProductsScreen extends StatefulWidget {
  final Category category;
  final Function(Category) onCategoryUpdated;

  const ProductsScreen({
    Key? key,
    required this.category,
    required this.onCategoryUpdated,
  }) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Category _currentCategory;

  @override
  void initState() {
    super.initState();
    _currentCategory = widget.category;
  }

  void _addProduct() {
    showDialog(
      context: context,
      builder: (context) => AddEditProductDialog(
        categoryId: _currentCategory.id,
        onSave: (product) {
          setState(() {
            _currentCategory.products.add(product);
          });
          _updateParent();
        },
      ),
    );
  }

  void _editProduct(Product product) {
    showDialog(
      context: context,
      builder: (context) => AddEditProductDialog(
        product: product,
        categoryId: _currentCategory.id,
        onSave: (updatedProduct) {
          setState(() {
            final index = _currentCategory.products
                .indexWhere((p) => p.id == product.id);
            if (index != -1) {
              _currentCategory.products[index] = updatedProduct;
            }
          });
          _updateParent();
        },
      ),
    );
  }

  void _deleteProduct(String productId) {
    setState(() {
      _currentCategory.products
          .removeWhere((product) => product.id == productId);
    });
    _updateParent();
  }

  void _updateParent() {
    widget.onCategoryUpdated(_currentCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentCategory.name),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _currentCategory.products.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _currentCategory.icon,
              style: const TextStyle(fontSize: 64),
            ),
            const SizedBox(height: 16),
            const Text(
              'Нет товаров в этой категории',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: _currentCategory.products.length,
        itemBuilder: (context, index) {
          final product = _currentCategory.products[index];
          final isLowStock = product.quantity < product.minQuantity;

          return ProductCard(
            product: product,
            isLowStock: isLowStock,
            onEdit: () => _editProduct(product),
            onDelete: () => _deleteProduct(product.id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        child: const Icon(Icons.add),
      ),
    );
  }
}