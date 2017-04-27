import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:config/config_service.dart';
import '../contract/general/contract_general_model.dart';
import 'package:logger/logger_service.dart';
import 'package:angular_utils/cm_format_money_pipe.dart';
import 'package:angular_utils/cm_format_currency_pipe.dart';

import '../contracts_service/contracts_service.dart';

@Component(
  selector: 'contract-list',
  templateUrl: 'contract_list_component.html',
  directives: const [RouterLink],
  pipes: const [CmFormatMoneyPipe, CmFormatCurrencyPipe]
  )
class ContractListComponent implements AfterViewInit {
  final Router _router;
  final LoggerService _logger;
  final ConfigService _config;
  final ContractsService _service;
  static const DisplayName = const {'displayName': 'Список договоров'};

  List<Map> contracts = new List<Map>();

  ContractListComponent(
      this._router, this._logger, this._config, this._service);

  @override
  ngAfterViewInit() async {
    List<ContractGeneralModel> contractsList = await _service.general.getContracts();

    for (ContractGeneralModel contract in contractsList) {
      contracts.add(contract.toMap());
    }
  }

  Future createContract() async {
    var newContractModel = new ContractGeneralModel();

    String contractId = await _service.general.createContract(newContractModel);

    _service.writeEnabled = true;
    _router.parent.navigate([
      'Contract',
      {'id': contractId}
    ]);

    return null;
  }
}