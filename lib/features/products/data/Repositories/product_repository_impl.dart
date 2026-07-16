import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl(this.localDataSource);

  @override
  Future<void> addProduct(Product product) async {
    await localDataSource.addProduct(product);
  }

  @override
  Future<void> updateProduct(Product product) async {
    await localDataSource.updateProduct(product);
  }

  @override
  Future<void> deleteProduct(int id) async {
    await localDataSource.deleteProduct(id);
  }

  @override
  Future<List<Product>> getAllProducts() async {
    return await localDataSource.getAllProducts();
  }

  @override
  Future<Product?> getByBarcode(String barcode) async {
    return await localDataSource.getByBarcode(barcode);
  }

  @override
  Future<List<Product>> searchProducts(String keyword) async {
    return await localDataSource.searchProducts(keyword);
  }
}
