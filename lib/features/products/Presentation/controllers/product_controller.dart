import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/dependency_injection.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/add_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/search_product_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';

final productControllerProvider =
    StateNotifierProvider<ProductController, AsyncValue<List<Product>>>(
  (ref) => ProductController(),
);

class ProductController extends StateNotifier<AsyncValue<List<Product>>> {
  ProductController() : super(const AsyncValue.loading()) {
    _initialize();
  }

  late final GetProductsUseCase _getProducts;
  late final AddProductUseCase _addProduct;
  late final UpdateProductUseCase _updateProduct;
  late final DeleteProductUseCase _deleteProduct;
  late final SearchProductUseCase _searchProduct;

  Future<void> _initialize() async {
    _getProducts = await DependencyInjection.getProductsUseCase();
    _addProduct = await DependencyInjection.addProductUseCase();
    _updateProduct = await DependencyInjection.updateProductUseCase();
    _deleteProduct = await DependencyInjection.deleteProductUseCase();
    _searchProduct = await DependencyInjection.searchProductUseCase();

    await loadProducts();
  }

  Future<void> loadProducts() async {
    state = const AsyncValue.loading();

    try {
      final products = await _getProducts();

      state = AsyncValue.data(products);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> add(Product product) async {
    await _addProduct(product);
    await loadProducts();
  }

  Future<void> update(Product product) async {
    await _updateProduct(product);
    await loadProducts();
  }

  Future<void> delete(int id) async {
    await _deleteProduct(id);
    await loadProducts();
  }

  Future<void> search(String keyword) async {
    if (keyword.trim().isEmpty) {
      await loadProducts();
      return;
    }

    final products = await _searchProduct(keyword);

    state = AsyncValue.data(products);
  }
}