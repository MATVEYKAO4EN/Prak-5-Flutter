// widgets/product_card.dart (альтернативный вариант)
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isLowStock;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCard({
    Key? key,
    required this.product,
    required this.isLowStock,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isLowStock ? Colors.red[100] : Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Иконка
            Text(
              product.icon,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(width: 16),

            // Информация о товаре
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Количество: ${product.quantity}',
                    style: TextStyle(
                      fontSize: 16,
                      color: isLowStock ? Colors.red : Colors.black,
                      fontWeight: isLowStock ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  Text(
                    'Мин. количество: ${product.minQuantity}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  if (isLowStock)
                    Text(
                      'Низкий запас!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),

            // Компактное меню
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.grey),
              itemBuilder: (context) => [
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Редактировать'),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Удалить', style: TextStyle(color: Colors.red)),
                ),
              ],
              onSelected: (value) {
                if (value == 'edit') onEdit();
                if (value == 'delete') onDelete();
              },
            ),
          ],
        ),
      ),
    );
  }
}