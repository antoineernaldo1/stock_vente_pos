import '../entities/product.dart';
import '../repositories/product_repository.dart';

class SearchProductUseCase {
  final ProductRepository repository;

  SearchProductUseCase(this.repository);

  Future<List<Product>> call(String keyword) {
    return repository.searchProducts(keyword);
  }
}
