import 'dart:async';

import 'contract_general_model.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:master_layout/breadcrumb_service.dart';
import 'contract_general_write_component.dart';
import 'contract_general_read_component.dart';
import '../../contracts_service/contracts_service.dart';
import '../general/amount.dart';

@Component(
    selector: 'contract-general',
    templateUrl: 'contract_general_component.html',
    directives: const [
      ContractGeneralWriteComponent,
      ContractGeneralReadComponent
    ])
class ContractGeneralComponent implements OnInit {
  final ContractsService service;
  final Router _router;

  static const DisplayName = 'Общая информация';

  ContractGeneralComponent(this.service, this._router);

  @override
  Future ngOnInit() async {
    if (!service.creatingMode) {
      service.model = await service.general.getContract(service.contractId);
    } else {
      service.model = new ContractGeneralModel();
      service.model.amounts.add(new Amount()..currencySysName = 'RUR');
      service.writeEnabled = true;
    }
  }
}
