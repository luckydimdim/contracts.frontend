import 'dart:async';
import 'dart:convert';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:http/browser_client.dart';

import 'package:config/config_service.dart';

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

  ContractCreateViewModel(
      [this.name,
      this.number,
      this.startDate,
      this.finishDate,
      this.contractorName,
      this.currency,
      this.amount,
      this.vatIncluded,
      this.constructionObjectName,
      this.constructionObjectTitleName,
      this.constructionObjectTitleCode,
      this.description]);
}

@Component(
  selector: 'contract-create',
  providers: const [BrowserClient])
@View(
    templateUrl: 'contract_create_component.html',
    directives: const [RouterLink])
class ContractCreateComponent {
  static const DisplayName = const {'displayName': 'Создание договора'};
  ContractCreateViewModel model = new ContractCreateViewModel();
  BrowserClient _http;
  ConfigService _config;
  String _backendUrl;

  ContractCreateComponent(this._http, this._config) {}

  Future onSubmit() async {
    String _backendUrl = await _config.Get<String>('backend_url', 'http://localhost:5000');

    try {
      // TODO: научиться преобразовывать объекты к json
      return await _http.post(_backendUrl,
        /*headers: {'Content-Type': 'application/json'},*/
        body: {
          "name": "${model.name}",
          "number": "${model.number}",
          "startDate": "${model.startDate}",
          "finishDate": "${model.finishDate}",
          "contractorName": "${model.contractorName}",
          "currency": "${model.currency}",
          "amount": "${model.amount}",
          "vatIncluded": "${model.vatIncluded}",
          "constructionObjectName": "${model.constructionObjectName}",
          "constructionObjectTitleName": "${model.constructionObjectTitleName}",
          "constructionObjectTitleCode": "${model.constructionObjectTitleCode}",
          "description": "${model.description}"
        });
    } catch (e) {
      print('Failed to create contract: $e');

      return new Exception('Failed to create contract. Cause: $e');
    }
  }
}