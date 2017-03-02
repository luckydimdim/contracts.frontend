import 'dart:async';
import 'dart:convert';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:http/browser_client.dart';

import 'package:config/config_service.dart';
import 'package:logger/logger_service.dart';

import '../contract/contract_layout/contract_layout_component.dart';

/**
 * Модель представления договора
 */
class ContractCreateViewModel {
  String name;
  String number;
  String startDate;
  String finishDate;
  String contractorName;
  String currency;
  String amount;
  bool vatIncluded;
  String constructionObjectName;
  String constructionObjectTitleName;
  String constructionObjectTitleCode;
  String description;

  ContractCreateViewModel();

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

@Component(selector: 'contract-create', providers: const [BrowserClient])
@View(
    templateUrl: 'contract_create_component.html',
    directives: const [RouterLink, ContractLayoutComponent])
class ContractCreateComponent {
  static const DisplayName = const {'displayName': 'Создание договора'};
  ContractCreateViewModel model = new ContractCreateViewModel();
  BrowserClient _http;
  ConfigService _config;
  LoggerService _logger;

  ContractCreateComponent(this._http, this._config, this._logger) {}

  Future onSubmit() async {
    _logger.trace('Creating contract ${model.toJsonString()}');
    print(model.toJsonString());

    try {
      await _http.post(_config.helper.contractsUrl,
          headers: {'Content-Type': 'application/json'},
          body: model.toJsonString());
      _logger.trace('Contract ${model.name} created');

      return null;
    } catch (e) {
      print('Failed to create contract: $e');
      _logger.error('Failed to create contract: $e');

      return new Exception('Failed to create contract. Cause: $e');
    }
  }
}