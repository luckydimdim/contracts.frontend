import 'package:converters/json_converter.dart';
import 'package:converters/map_converter.dart';
import 'package:converters/reflector.dart';
import 'package:intl/intl.dart';
import 'amount.dart';

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
  DateTime startDate = null;

  // Дата окончания
  DateTime finishDate = null;

  // Имя подрядчика
  String contractorName = '';

  // Стоимости договора в разрезе валют
  @Json(exclude: true)
  List<Amount> amounts = new List<Amount>();

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

  String get startDateStr =>
      startDate == null ? '' : _formatter.format(startDate);

  String get finishDateStr =>
      finishDate == null ? '' : _formatter.format(finishDate);

  DateFormat _formatter = new DateFormat('dd.MM.yyyy');

  @override
  Map toJson() {
    var result = super.toJson();

    var amountsList = new List<Map>();

    amounts.forEach((a){
      amountsList.add(a.toJson());
    });

    result['amounts'] = amountsList;

    return result;
  }

  @override
  dynamic fromJson(dynamic json) {
    super.fromJson(json);

    for (dynamic amountJson in json['amounts']) {
      amounts.add(new Amount().fromJson(amountJson));
    }

    return this;
  }
}
