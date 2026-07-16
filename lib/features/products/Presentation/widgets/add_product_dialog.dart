import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/product.dart';
import '../controllers/product_controller.dart';

class AddProductDialog extends ConsumerStatefulWidget {
  final Product? product;

  const AddProductDialog({super.key, this.product});

  @override
  ConsumerState<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends ConsumerState<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _purchaseController = TextEditingController();
  final _sellingController = TextEditingController();
  final _stockController = TextEditingController();
  final _alertController = TextEditingController();

  bool _loading = false;

  bool get isEdit => widget.product != null;

  @override
  void initState() {
    super.initState();

    if (isEdit) {
      final product = widget.product!;

      _nameController.text = product.name;
      _barcodeController.text = product.barcode;
      _purchaseController.text = product.purchasePrice.toString();
      _sellingController.text = product.sellingPrice.toString();
      _stockController.text = product.stock.toString();
      _alertController.text = product.alertStock.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _barcodeController.dispose();
    _purchaseController.dispose();
    _sellingController.dispose();
    _stockController.dispose();
    _alertController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      final product = Product(
        id: isEdit ? widget.product!.id : null,
        uuid: isEdit ? widget.product!.uuid : const Uuid().v4(),
        name: _nameController.text.trim(),
        barcode: _barcodeController.text.trim(),
        categoryId: isEdit ? widget.product!.categoryId : '',
        supplierId: isEdit ? widget.product!.supplierId : '',
        image: isEdit ? widget.product!.image : '',
        purchasePrice: double.parse(_purchaseController.text),
        sellingPrice: double.parse(_sellingController.text),
        stock: int.parse(_stockController.text),
        alertStock: int.parse(_alertController.text),
        active: true,
        createdAt: isEdit ? widget.product!.createdAt : DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final controller = ref.read(productControllerProvider.notifier);

      if (isEdit) {
        await controller.update(product);
      } else {
        await controller.add(product);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Widget _numberField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Required';
        }

        if (double.tryParse(value) == null) {
          return 'Invalid number';
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEdit ? 'Edit Product' : 'Add Product'),

      content: SizedBox(
        width: 450,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Product name is required';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: _barcodeController,
                  decoration: InputDecoration(
                    labelText: 'Barcode',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                _numberField(_purchaseController, 'Purchase Price'),

                const SizedBox(height: 15),

                _numberField(_sellingController, 'Selling Price'),

                const SizedBox(height: 15),

                _numberField(_stockController, 'Stock'),

                const SizedBox(height: 15),

                _numberField(_alertController, 'Alert Stock'),
              ],
            ),
          ),
        ),
      ),

      actions: [
        TextButton(
          onPressed: _loading ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),

        FilledButton.icon(
          onPressed: _loading ? null : _save,
          icon: Icon(isEdit ? Icons.save : Icons.add),
          label: _loading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(isEdit ? 'Update' : 'Save'),
        ),
      ],
    );
  }
}
