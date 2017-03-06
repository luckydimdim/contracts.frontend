import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:json_object/json_object.dart';

import 'package:logger/logger_service.dart';

import '../contracts_service/contracts_service.dart';

@Component(
  selector: 'contract-general',
  templateUrl: 'contract_general_component.html',
  providers: const [LoggerService, ContractsService, RouteParams])
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
  final ContractsService _db;

  JsonObject contract = new JsonObject();

  ContractGeneralComponent(this._logger, this._routeParams, this._db) {}

  @override
  void ngOnInit() {
    breadcrumbInit();
  }

  void breadcrumbInit() {}

  @override
  ngAfterViewInit() async {
    int contractId = int.parse(_routeParams.get('id'));

    contract = await _db.getContract(contractId);
  }
}