import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:config/config_service.dart';
import '../../contract/src/general/contract_general_model.dart';
import 'package:logger/logger_service.dart';

import 'package:json_object/json_object.dart';
import '../../contracts_service/contracts_service.dart';

@Component(selector: 'contract-list')
@View(
    templateUrl: 'contract_list_component.html', directives: const [RouterLink])
class ContractListComponent implements OnInit, AfterViewInit {
  final Router _router;
  final LoggerService _logger;
  final ConfigService _config;
  final ContractsService _service;
  static const DisplayName = const {'displayName': 'Список договоров'};

  List<JsonObject> contracts = new List<JsonObject>();

  ContractListComponent(
      this._router, this._logger, this._config, this._service) {}

  void breadcrumbInit() {}

  @override
  void ngOnInit() {
    breadcrumbInit();
  }

  @override
  ngAfterViewInit() async {
    contracts = await _service.general.getContracts();
  }

  Future createContract() async {
    //Instruction ci = _router.parent.parent.currentInstruction;
    //String contractId = ci.component.params['id'];

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
