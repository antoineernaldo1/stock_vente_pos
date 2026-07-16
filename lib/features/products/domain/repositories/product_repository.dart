import '../entities/product.dart';

abstract class ProductRepository {
  Future<void> addProduct(Product product);

  Future<void> updateProduct(Product product);

  Future<void> deleteProduct(int id);

  Future<List<Product>> getAllProducts();

  Future<Product?> getByBarcode(String barcode);

  Future<List<Product>> searchProducts(String keyword);
}
