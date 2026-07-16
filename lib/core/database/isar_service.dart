import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/products/data/models/product_model.dart';
import '../../features/sales/data/models/sale_model.dart';

class IsarService {
  static Isar? _instance;

  static Future<Isar> instance() async {
    if (_instance != null) return _instance!;

    final dir = await getApplicationDocumentsDirectory();

    _instance = await Isar.open(
      [ProductModelSchema, SaleModelSchema],
      directory: dir.path,
      inspector: kDebugMode,
    );

    return _instance!;
  }
}
