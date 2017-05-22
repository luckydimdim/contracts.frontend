import 'contract_general_model.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'contract_general_write_component.dart';
import 'contract_general_read_component.dart';
import '../../contracts_service/contracts_service.dart';

@Component(
    selector: 'contract-general',
    templateUrl: 'contract_general_component.html',
    directives: const [
      ContractGeneralWriteComponent,
      ContractGeneralReadComponent
    ])
class ContractGeneralComponent implements OnInit, AfterViewInit {
  final ContractsService service;
  final Router _router;
  ContractGeneralModel model = new ContractGeneralModel();
  static const DisplayName = const {'displayName': 'Общая информация'};

  ContractGeneralComponent(this.service, this._router);

  @override
  ngOnInit() async {
    Instruction ci = _router.parent.parent.currentInstruction;
    String contractId = ci.component.params['id'];

    model = await service.general.getContract(contractId);
  }

  @override
  ngAfterViewInit() {}
}
