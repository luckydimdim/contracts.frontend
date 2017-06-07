import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:auth/auth_service.dart';
import 'package:angular_utils/cm_format_money_pipe.dart';
import 'package:angular_utils/cm_format_currency_pipe.dart';

import '../contract/general/contract_general_model.dart';
import '../contract/general/contract_general_service.dart';

@Component(
    selector: 'contract-list',
    templateUrl: 'contract_list_component.html',
    directives: const [RouterLink],
    pipes: const [CmFormatMoneyPipe, CmFormatCurrencyPipe])
class ContractListComponent implements AfterViewInit, OnInit {
  final Router _router;
  final ContractGeneralService _service;
  final AuthorizationService _authorizationService;
  static const DisplayName = const {'displayName': 'Список договоров'};

  bool readOnly = true;

  List<Map> contracts = new List<Map>();

  ContractListComponent(
      this._router, this._service, this._authorizationService);

  @override
  ngOnInit() {
    if (_authorizationService.isInRole(Role.Customer)) readOnly = false;
  }

  @override
  ngAfterViewInit() async {
    List<ContractGeneralModel> contractsList = await _service.getContracts();

    for (ContractGeneralModel contract in contractsList) {
      contracts.add(contract.toMap());
    }
  }

  Future createContract() async {
    /*var newContractModel = new ContractGeneralModel();

    String contractId = await _service.general.createContract(newContractModel);

    _service.writeEnabled = true;
    _router.parent.navigate([
      'Contract',
      {'id': contractId}
    ]);

    return null;*/

    _router.parent.navigate([
      'ContractCreate',
    ]);
  }

  String getContractNumber(Map contract){
    var number = contract['number'];

    if (number == null || number == '') {
      return '???????';
    }

    else
      return number;

  }

}
