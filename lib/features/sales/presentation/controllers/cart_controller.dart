import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/cart_item.dart';
import '../../../products/domain/entities/product.dart';

final cartControllerProvider =
    StateNotifierProvider<CartController, List<CartItem>>(
      (ref) => CartController(),
    );

class CartController extends StateNotifier<List<CartItem>> {
  CartController() : super([]);

  void addProduct(Product product) {
    final index = state.indexWhere((e) => e.product.uuid == product.uuid);

    if (index >= 0) {
      final item = state[index];

      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index)
            item.copyWith(quantity: item.quantity + 1)
          else
            state[i],
      ];
    } else {
      state = [...state, CartItem(product: product, quantity: 1)];
    }
  }

  void increase(Product product) {
    addProduct(product);
  }

  void decrease(Product product) {
    final index = state.indexWhere((e) => e.product.uuid == product.uuid);

    if (index == -1) return;

    final item = state[index];

    if (item.quantity == 1) {
      remove(product);
      return;
    }

    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          item.copyWith(quantity: item.quantity - 1)
        else
          state[i],
    ];
  }

  void remove(Product product) {
    state = state.where((e) => e.product.uuid != product.uuid).toList();
  }

  void clear() {
    state = [];
  }

  double get total {
    return state.fold(0, (sum, item) => sum + item.subtotal);
  }
}
