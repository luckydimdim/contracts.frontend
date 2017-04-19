import 'package:converters/json_converter.dart';
import 'package:converters/map_converter.dart';
import 'package:converters/reflector.dart';

@reflectable
/**
 * Модель представления договора
 */
class ContractGeneralModel extends Object with JsonConverter, MapConverter {
  // Внутренний идентификатор
  String id = '';

  // Название договора
  String name = '';

  // Номер договора
  String number = '';

  // Дата заключения
  String startDate = null;

  // Дата окончания
  String finishDate = null;

  // Имя подрядчика
  String contractorName = '';

  // Валюта договора
  String currency = '';

  // Стоимость договора
  String amount = '0';

  // НДC включен в стоимость договора
  bool vatIncluded = false;

  // Название объекта строительства
  String constructionObjectName = '';

  // Название объекта строительства по титульному списку
  String constructionObjectTitleName = '';

  // Код титульного списка объекта строительства
  String constructionObjectTitleCode = '';

  // Примечания к договору
  String description = '';

  // Шаблон договора
  String templateSysName = 'default';

  ContractGeneralModel();

  factory ContractGeneralModel.fromJson(dynamic json) {
    return new ContractGeneralModel().fromJson(json);
  }
}
