import 'dart:convert';

/**
 * Модель представления договора
 */
class ContractCreateViewModel {
  String name;
  String number;
  String startDate;
  String finishDate;
  String contractorName;
  /*Map<String, String> currency;*/
  String currency;
  String amount;
  bool vatIncluded;
  String constructionObjectName;
  String constructionObjectTitleName;
  String constructionObjectTitleCode;
  String description;

  ContractCreateViewModel() {
    /*currency = getCurrencies();
    currency.forEach((k, v) => print('$k => $v'));*/
  }

  String toJsonString() {
    var map = new Map();

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

    return JSON.encode(map);
  }
}