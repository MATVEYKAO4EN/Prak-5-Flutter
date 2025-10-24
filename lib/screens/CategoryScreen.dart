// screens/categories_screen.dart
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/product.dart';
import 'ProductScreen.dart';
import '../widgets/categoryCard.dart';
import '../widgets/addCategoryDialog.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> _categories = [
    Category(
      id: '1',
      name: 'Молочка',
      icon: '🥛',
      products: [
        Product(
          id: '1',
          name: 'Молоко',
          quantity: 10,
          minQuantity: 5,
          icon: '🥛',
          categoryId: '1',
        ),
        Product(
          id: '2',
          name: 'Сыр',
          quantity: 3,
          minQuantity: 4,
          icon: '🧀',
          categoryId: '1',
        ),
      ],
    ),
    Category(
      id: '2',
      name: 'Овощи',
      icon: '🥦',
      products: [
        Product(
          id: '3',
          name: 'Помидоры',
          quantity: 15,
          minQuantity: 8,
          icon: '🍅',
          categoryId: '2',
        ),
      ],
    ),
    Category(
      id: '3',
      name: 'Фрукты',
      icon: '🍎',
      products: [
        Product(
          id: '4',
          name: 'Яблоки',
          quantity: 20,
          minQuantity: 10,
          icon: '🍎',
          categoryId: '3',
        ),
      ],
    ),
  ];

  void _addCategory() {
    showDialog(
      context: context,
      builder: (context) => AddEditCategoryDialog(
        onSave: (category) {
          setState(() {
            _categories.add(category);
          });
        },
      ),
    );
  }

  void _editCategory(Category category) {
    showDialog(
      context: context,
      builder: (context) => AddEditCategoryDialog(
        category: category,
        onSave: (updatedCategory) {
          setState(() {
            final index = _categories.indexWhere((c) => c.id == category.id);
            if (index != -1) {
              _categories[index] = updatedCategory;
            }
          });
        },
      ),
    );
  }

  void _deleteCategory(String categoryId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить категорию?'),
        content: const Text('Все товары в этой категории также будут удалены.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _categories.removeWhere((category) => category.id == categoryId);
              });
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Удалить', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _navigateToProducts(Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductsScreen(
          category: category,
          onCategoryUpdated: (updatedCategory) {
            setState(() {
              final index = _categories.indexWhere((c) => c.id == category.id);
              if (index != -1) {
                _categories[index] = updatedCategory;
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Категории товаров'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _categories.isEmpty
          ? const Center(
        child: Text(
          'Нет категорий',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final lowStockCount = category.products
              .where((product) => product.quantity < product.minQuantity)
              .length;

          return CategoryCard(
            category: category,
            lowStockCount: lowStockCount,
            onTap: () => _navigateToProducts(category),
            onEdit: () => _editCategory(category),
            onDelete: () => _deleteCategory(category.id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCategory,
        child: const Icon(Icons.add),
      ),
    );
  }
}