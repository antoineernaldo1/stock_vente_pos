import '../../domain/entities/product.dart';

abstract class ProductLocalDataSource {
  Future<void> addProduct(Product product);

  Future<void> updateProduct(Product product);

  Future<void> deleteProduct(int id);

  Future<List<Product>> getAllProducts();

  Future<Product?> getByBarcode(String barcode);

  Future<List<Product>> searchProducts(String keyword);
}
