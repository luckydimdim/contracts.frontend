import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:auth/auth_service.dart';
import 'package:angular_utils/pipes.dart';
import 'package:grid/grid.dart';
import '../contract/general/contract_general_model.dart';
import '../contract/general/contract_general_service.dart';

@Component(
    selector: 'contract-list',
    templateUrl: 'contract_list_component.html',
    directives: const [
      RouterLink,
      GridComponent,
      GridTemplateDirective,
      ColumnComponent,
    ],
    pipes: const [
      CmFormatMoneyPipe,
      CmFormatCurrencyPipe
    ])
class ContractListComponent implements OnInit {
  final Router _router;
  final ContractGeneralService _service;
  final AuthorizationService _authorizationService;
  static const DisplayName = const {'displayName': 'Список договоров'};

  bool readOnly = false;

  DataSource dataSource;

  ContractListComponent(
      this._router, this._service, this._authorizationService);

  @override
  ngOnInit() async {
    if (_authorizationService.isInRole(Role.Contractor)) readOnly = true;

    List<ContractGeneralModel> contractsList = await _service.getContracts();

    List<Map> contracts = new List<Map>();
    for (ContractGeneralModel contract in contractsList) {
      contracts.add(contract.toMap());
    }

    dataSource = new DataSource(data: contracts)..primaryField = 'id';
  }

  Future createContract() async {
    _router.parent.navigate([
      'ContractCreate',
    ]);
  }

  String getContractNumber(Map contract) {
    var number = contract['number'];

    if (number == null || number == '') {
      return '???????';
    } else
      return number;
  }
}
