import 'package:converters/json_converter.dart';
import 'package:converters/map_converter.dart';
import 'package:converters/reflector.dart';

/**
 * Модель представления договора
 */
@reflectable
class ContractGeneralModel extends Object with JsonConverter, MapConverter {
  String id;
  String name;
  String number;
  String startDate;
  String finishDate;
  String contractorName;
  String currency;
  String amount;
  bool vatIncluded = false;
  String constructionObjectName;
  String constructionObjectTitleName;
  String constructionObjectTitleCode;
  String description;
  String templateSysName = 'default';

  ContractGeneralModel();

  factory ContractGeneralModel.fromJson(dynamic json) {
    return new ContractGeneralModel().fromJson(json);
  }
}
