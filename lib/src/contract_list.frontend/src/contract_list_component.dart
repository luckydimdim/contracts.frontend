import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:config/config_service.dart';
import 'package:logger/logger_service.dart';

import 'package:json_object/json_object.dart';

@Component(
  selector: 'contract-list',
  providers: const [LoggerService, ConfigService])
@View(
  templateUrl: 'contract_list_component.html',
  directives: const [RouterLink])
class ContractListComponent implements OnInit, AfterViewInit {
  final Router _router;
  final LoggerService _logger;
  final ConfigService _config;
  static const DisplayName = const {'displayName': 'Список договоров'};

  List<JsonObject> contracts = new List<JsonObject>();

  ContractListComponent(this._router, this._logger, this._config) {}

  void breadcrumbInit() {}

  @override
  void ngOnInit() {
    breadcrumbInit();

    var table = querySelector('[table-click]') as TableElement;
    table.rows.forEach((TableRowElement row) {
      row.onClick.listen((MouseEvent e) {
        var currentRow = e.currentTarget as TableRowElement;
        String link = currentRow.getAttribute('data-href');

        _router.parent.navigateByUrl(link);
      });
    });
  }

  @override
  Future ngAfterViewInit() async {
    _logger.trace('Requesting contracts. Url: ${_config.helper.contractsUrl}');
    String response = await HttpRequest.getString(_config.helper.contractsUrl);
    _logger.trace('Contracts requested: $response.');
    contracts = JSON.decode(response);

    var contract = new JsonObject();
    contract.name = '1';
    contract.number = '2';
    contract.startDate = '3';
    contract.finishDate = '4';
    contract.contractorName = '5';
    contract.currency = '6';
    contract.amount = '7';
    contract.vatIncluded = '8';
    contract.constructionObjectName = '9';
    contract.constructionObjectTitleName = '10';
    contract.constructionObjectTitleCode = '11';
    contract.description = '12';

    contracts.add(contract);
  }
}