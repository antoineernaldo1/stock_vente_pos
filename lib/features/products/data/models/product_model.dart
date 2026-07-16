import 'package:isar_community/isar.dart';

// ignore: uri_does_not_exist
part 'product_model.g.dart';

@collection
class ProductModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;

  @Index(unique: true, replace: true)
  late String barcode;

  late String categoryId;

  late String supplierId;

  String? image;

  late double purchasePrice;

  late double sellingPrice;

  late int stock;

  late int alertStock;

  late bool active;

  late DateTime createdAt;

  late DateTime updatedAt;

  /// Pou Firestore Sync
  late bool synced;

  /// Efase lokalman men poko sync
  late bool deleted;
}
