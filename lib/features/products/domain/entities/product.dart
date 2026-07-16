class Product {
  final int? id;

  final String uuid;

  final String name;

  final String barcode;

  final String categoryId;

  final String supplierId;

  final String image;

  final double purchasePrice;

  final double sellingPrice;

  final int stock;

  final int alertStock;

  final bool active;

  final DateTime createdAt;

  final DateTime updatedAt;

  const Product({
    this.id,
    required this.uuid,
    required this.name,
    required this.barcode,
    required this.categoryId,
    required this.supplierId,
    required this.image,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.stock,
    required this.alertStock,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  double get profit => sellingPrice - purchasePrice;
}
