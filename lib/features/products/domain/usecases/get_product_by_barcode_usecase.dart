import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductByBarcodeUseCase {
  final ProductRepository repository;

  GetProductByBarcodeUseCase(this.repository);

  Future<Product?> call(String barcode) {
    return repository.getByBarcode(barcode);
  }
}
