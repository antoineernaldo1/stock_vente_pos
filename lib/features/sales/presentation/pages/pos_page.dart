import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../products/presentation/controllers/product_controller.dart';
import '../controllers/cart_controller.dart';

class PosPage extends ConsumerWidget {
  const PosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productControllerProvider);

    final cart = ref.watch(cartControllerProvider);

    final cartController = ref.read(cartControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Point Of Sale"), centerTitle: true),

      body: Row(
        children: [
          /// PRODUCTS
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Search product / barcode...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      ref
                          .read(productControllerProvider.notifier)
                          .search(value);
                    },
                  ),
                ),

                Expanded(
                  child: productsState.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),

                    error: (e, _) => Center(child: Text(e.toString())),

                    data: (products) {
                      if (products.isEmpty) {
                        return const Center(child: Text("No products"));
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.all(16),

                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: 1.15,
                            ),

                        itemCount: products.length,

                        itemBuilder: (context, index) {
                          final product = products[index];

                          return Card(
                            elevation: 3,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),

                              onTap: () {
                                cartController.addProduct(product);
                              },

                              child: Padding(
                                padding: const EdgeInsets.all(12),

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    const Icon(Icons.inventory_2, size: 42),

                                    const SizedBox(height: 10),

                                    Text(
                                      product.name,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      "\$${product.sellingPrice.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),

                                    Text("Stock : ${product.stock}"),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const VerticalDivider(width: 1),

          /// CART
          SizedBox(
            width: 390,

            child: Column(
              children: [
                Container(
                  height: 60,
                  alignment: Alignment.center,

                  child: const Text(
                    "Shopping Cart",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),

                Expanded(
                  child: cart.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 90,
                                color: Colors.grey,
                              ),

                              SizedBox(height: 15),

                              Text(
                                "Cart is Empty",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: cart.length,

                          itemBuilder: (context, index) {
                            final item = cart[index];

                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(10),

                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.product.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),

                                          onPressed: () {
                                            cartController.remove(item.product);
                                          },
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 8),

                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),

                                          onPressed: () {
                                            cartController.decrease(
                                              item.product,
                                            );
                                          },
                                        ),

                                        Text(
                                          item.quantity.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        IconButton(
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                          ),

                                          onPressed: () {
                                            cartController.increase(
                                              item.product,
                                            );
                                          },
                                        ),

                                        const Spacer(),

                                        Text(
                                          "\$${item.subtotal.toStringAsFixed(2)}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),

                const Divider(),

                Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text("Items : ${cart.length}"),

                                const SizedBox(height: 5),

                                const Text(
                                  "TOTAL",

                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Text(
                            "\$${cartController.total.toStringAsFixed(2)}",

                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 55,

                        child: FilledButton.icon(
                          onPressed: cart.isEmpty
                              ? null
                              : () {
                                  /// Checkout
                                },

                          icon: const Icon(Icons.payment),

                          label: const Text("Checkout"),
                        ),
                      ),

                      const SizedBox(height: 10),

                      SizedBox(
                        width: double.infinity,

                        child: OutlinedButton.icon(
                          onPressed: cart.isEmpty
                              ? null
                              : () {
                                  cartController.clear();
                                },

                          icon: const Icon(Icons.delete_sweep),

                          label: const Text("Clear Cart"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
