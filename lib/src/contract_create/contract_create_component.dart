import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:http/browser_client.dart';

import 'package:config/config_service.dart';
import 'package:logger/logger_service.dart';

import '../contract/contract_layout/contract_layout_component.dart';
import 'contract_create_view_model.dart';


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