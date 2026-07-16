import 'package:isar_community/isar.dart';

part 'sale_model.g.dart';

@collection
class SaleModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String invoiceNumber;

  late DateTime date;

  late double total;

  late bool synced;

  late bool deleted;
}
