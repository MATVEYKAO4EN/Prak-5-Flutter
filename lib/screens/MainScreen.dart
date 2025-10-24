// screens/main_screen.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/addProductDialog.dart';
import '../widgets/productCard.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Ноутбуки',
      quantity: 5,
      minQuantity: 3,
      icon: '💻',
    ),
    Product(
      id: '2',
      name: 'Мышки',
      quantity: 2,
      minQuantity: 5,
      icon: '🖱️',
    ),
    Product(
      id: '3',
      name: 'Клавиатуры',
      quantity: 10,
      minQuantity: 4,
      icon: '⌨️',
    ),
  ];

  void _addProduct() {
    showDialog(
      context: context,
      builder: (context) => AddEditProductDialog(
        onSave: (product) {
          setState(() {
            _products.add(product);
          });
        },
      ),
    );
  }

  void _editProduct(Product product) {
    showDialog(
      context: context,
      builder: (context) => AddEditProductDialog(
        product: product,
        onSave: (updatedProduct) {
          setState(() {
            final index = _products.indexWhere((p) => p.id == product.id);
            if (index != -1) {
              _products[index] = updatedProduct;
            }
          });
        },
      ),
    );
  }

  void _deleteProduct(String productId) {
    setState(() {
      _products.removeWhere((product) => product.id == productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Складской учет'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _products.isEmpty
          ? const Center(
        child: Text(
          'Нет товаров',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
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