import 'package:isar_community/isar.dart';

import '../../domain/entities/product.dart';
import '../models/product_mapper.dart';
import '../models/product_model.dart';
import 'product_local_datasource.dart';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Isar isar;

  ProductLocalDataSourceImpl(this.isar);

  @override
  Future<void> addProduct(Product product) async {
    final model = product.toModel();

    await isar.writeTxn(() async {
      await isar.productModels.put(model);
    });
  }

  @override
  Future<void> updateProduct(Product product) async {
    final model = product.toModel();

    await isar.writeTxn(() async {
      await isar.productModels.put(model);
    });
  }

  @override
  Future<void> deleteProduct(int id) async {
    await isar.writeTxn(() async {
      await isar.productModels.delete(id);
    });
  }

  @override
  Future<List<Product>> getAllProducts() async {
    final models = await isar.productModels.where().findAll();

    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<Product?> getByBarcode(String barcode) async {
    final model = await isar.productModels
        .filter()
        .barcodeEqualTo(barcode)
        .findFirst();

    return model?.toEntity();
  }

  @override
  Future<List<Product>> searchProducts(String keyword) async {
    final models = await isar.productModels
        .filter()
        .nameContains(keyword, caseSensitive: false)
        .findAll();

    return models.map((e) => e.toEntity()).toList();
  }
}
