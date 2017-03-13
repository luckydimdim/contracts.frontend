import 'contract_general_model.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:logger/logger_service.dart';

import 'contract_general_write_component.dart';
import 'contract_general_read_component.dart';
import '../../../contracts_service/contracts_service.dart';

@Component(
  selector: 'contract-general',
  templateUrl: 'contract_general_component.html',
  directives: const[ContractGeneralWriteComponent, ContractGeneralReadComponent])
class ContractGeneralComponent implements OnInit, AfterViewInit {
  static const String route_name = 'ContractGeneral';
  static const String route_path = 'general';
  static const Route route = const Route(
      path: ContractGeneralComponent.route_path,
      component: ContractGeneralComponent,
      name: ContractGeneralComponent.route_name,
      useAsDefault: true);

  final LoggerService _logger;
  final RouteParams _routeParams;
  final ContractsService service;
  final Router _router;
  ContractGeneralModel model = new ContractGeneralModel();

  ContractGeneralComponent(this._logger, this._routeParams, this.service, this._router);

  @override
  ngOnInit() async {
    breadcrumbInit();

    Instruction ci = _router.parent.parent.currentInstruction;
    String contractId = ci.component.params['id'];

    model = await service.general.getContract(contractId);
  }

  void breadcrumbInit() {}

  @override
  ngAfterViewInit() {}
}