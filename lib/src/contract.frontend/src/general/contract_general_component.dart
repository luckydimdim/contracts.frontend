import 'dart:html';
import 'dart:convert';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:json_object/json_object.dart';

import 'package:config/config_service.dart';
import 'package:logger/logger_service.dart';

@Component(
  selector: 'contract-general',
  templateUrl: 'contract_general_component.html',
  providers: const [ConfigService, LoggerService])
class ContractGeneralComponent implements OnInit, AfterViewInit {
  static const String route_name = 'ContractGeneral';
  static const String route_path = 'general';
  static const Route route = const Route(
      path: ContractGeneralComponent.route_path,
      component: ContractGeneralComponent,
      name: ContractGeneralComponent.route_name,
      useAsDefault: true);

  final ConfigService _config;
  final LoggerService _logger;
  final RouteParams _routeParams;

  JsonObject contract = new JsonObject();

  ContractGeneralComponent(this._config, this._logger, this._routeParams) {}

  @override
  void ngOnInit() {
    breadcrumbInit();
  }

  void breadcrumbInit() {}

  @override
  ngAfterViewInit() async {
    String contractId = _routeParams.get('id');

    /*_logger.trace('Requesting contract. Url: ${_config.helper.contractsUrl}/$contractId');
    String response = await HttpRequest.getString('${_config.helper.contractsUrl}/$contractId');
    _logger.trace('Contract requested: $response.');

    contract = JSON.decode(response);*/

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
  }
}