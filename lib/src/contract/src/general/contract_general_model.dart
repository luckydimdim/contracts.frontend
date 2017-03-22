import 'dart:convert';
/**
 * Модель представления договора
 */
class ContractGeneralModel {
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
    return new ContractGeneralModel()
      ..id = json['id']
      ..name = json['name']
      ..number = json['number']
      ..startDate = json['startDate']
      ..finishDate = json['finishDate']
      ..contractorName = json['contractorName']
      ..currency = json['currency']
      ..amount = json['amount']
      ..vatIncluded = json['vatIncluded']
      ..constructionObjectName = json['constructionObjectName']
      ..constructionObjectTitleName = json['constructionObjectTitleName']
      ..constructionObjectTitleCode = json['constructionObjectTitleCode']
      ..templateSysName = json['templateSysName']
      ..description = json['description'];
  }

  String toJsonString() {
    var map = new Map();

    map['id'] = id;
    map['name'] = name;
    map['number'] = number;
    map['startDate'] = startDate;
    map['finishDate'] = finishDate;
    map['contractorName'] = contractorName;
    map['currency'] = currency;
    map['amount'] = amount;
    map['vatIncluded'] = vatIncluded;
    map['constructionObjectName'] = constructionObjectName;
    map['constructionObjectTitleName'] = constructionObjectTitleName;
    map['constructionObjectTitleCode'] = constructionObjectTitleCode;
    map['description'] = description;
    map['templateSysName'] = templateSysName;

    return JSON.encode(map);
  }
}