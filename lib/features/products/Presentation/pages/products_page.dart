import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/product_controller.dart';
import '../widgets/add_product_dialog.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  Future<void> _deleteProduct(
    BuildContext context,
    WidgetRef ref,
    int id,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(productControllerProvider.notifier).delete(id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Products'), centerTitle: true),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const AddProductDialog(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
      ),

      body: productsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, stack) => Center(child: Text(error.toString())),

        data: (products) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search product...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    ref.read(productControllerProvider.notifier).search(value);
                  },
                ),
              ),

              Expanded(
                child: products.isEmpty
                    ? const Center(
                        child: Text(
                          'No products found',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 90,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];

                          final lowStock = product.stock <= product.alertStock;

                          return Card(
                            elevation: 3,
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),

                              leading: CircleAvatar(
                                radius: 28,
                                child: const Icon(Icons.inventory_2),
                              ),

                              title: Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),

                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Barcode: ${product.barcode}'),

                                    const SizedBox(height: 4),

                                    Text(
                                      'Purchase: \$${product.purchasePrice.toStringAsFixed(2)}',
                                    ),

                                    Text(
                                      'Selling: \$${product.sellingPrice.toStringAsFixed(2)}',
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      'Stock: ${product.stock}',
                                      style: TextStyle(
                                        color: lowStock
                                            ? Colors.red
                                            : Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              trailing: PopupMenuButton<String>(
                                onSelected: (value) async {
                                  switch (value) {
                                    case 'edit':
                                      showDialog(
                                        context: context,
                                        builder: (_) =>
                                            AddProductDialog(product: product),
                                      );
                                      break;

                                    case 'delete':
                                      if (product.id != null) {
                                        await _deleteProduct(
                                          context,
                                          ref,
                                          product.id!,
                                        );
                                      }
                                      break;
                                  }
                                },
                                itemBuilder: (_) => const [
                                  PopupMenuItem(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit),
                                        SizedBox(width: 10),
                                        Text('Edit'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, color: Colors.red),
                                        SizedBox(width: 10),
                                        Text('Delete'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
