// widgets/add_edit_product_dialog.dart
import 'package:flutter/material.dart';
import '../models/product.dart';

class AddEditProductDialog extends StatefulWidget {
  final Product? product;
  final Function(Product) onSave;

  const AddEditProductDialog({
    Key? key,
    this.product,
    required this.onSave,
  }) : super(key: key);

  @override
  State<AddEditProductDialog> createState() => _AddEditProductDialogState();
}

class _AddEditProductDialogState extends State<AddEditProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _minQuantityController = TextEditingController();
  final _iconController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _quantityController.text = widget.product!.quantity.toString();
      _minQuantityController.text = widget.product!.minQuantity.toString();
      _iconController.text = widget.product!.icon;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _minQuantityController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: widget.product?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        quantity: int.parse(_quantityController.text),
        minQuantity: int.parse(_minQuantityController.text),
        icon: _iconController.text,
      );

      widget.onSave(product);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product == null ? 'Добавить товар' : 'Редактировать товар'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Название товара'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите название товара';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Количество'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите количество';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Введите корректное число';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _minQuantityController,
                decoration: const InputDecoration(labelText: 'Минимальное количество'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите минимальное количество';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Введите корректное число';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _iconController,
                decoration: const InputDecoration(labelText: 'Иконка (эмодзи)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите иконку';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: _saveProduct,
          child: const Text('Сохранить'),
        ),
      ],
    );
  }
}