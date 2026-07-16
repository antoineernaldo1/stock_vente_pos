import 'package:isar_community/isar.dart';

import '../../domain/entities/product.dart';
import 'product_model.dart';

extension ProductModelMapper on ProductModel {
  Product toEntity() {
    return Product(
      id: id,
      uuid: uuid,
      name: name,
      barcode: barcode,
      categoryId: categoryId,
      supplierId: supplierId,
      image: image ?? '',
      purchasePrice: purchasePrice,
      sellingPrice: sellingPrice,
      stock: stock,
      alertStock: alertStock,
      active: active,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ProductEntityMapper on Product {
  ProductModel toModel() {
    return ProductModel()
      ..id = id ?? Isar.autoIncrement
      ..uuid = uuid
      ..name = name
      ..barcode = barcode
      ..categoryId = categoryId
      ..supplierId = supplierId
      ..image = image
      ..purchasePrice = purchasePrice
      ..sellingPrice = sellingPrice
      ..stock = stock
      ..alertStock = alertStock
      ..active = active
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      ..synced = false
      ..deleted = false;
  }
}
