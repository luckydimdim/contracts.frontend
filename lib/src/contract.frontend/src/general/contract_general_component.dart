import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:json_object/json_object.dart';

import 'package:logger/logger_service.dart';

import '../contracts_service/contracts_service.dart';
import 'contract_general_write_component.dart';
import 'contract_general_read_component.dart';

@Component(
  selector: 'contract-general',
  templateUrl: 'contract_general_component.html',
  providers: const [LoggerService, ContractsService],
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
  final ContractsService _db;
  final Router _router;

  JsonObject contract = new JsonObject();

  bool writeEnabled = false;

  ContractGeneralComponent(this._logger, this._routeParams, this._db, this._router);

  @override
  ngOnInit() async {
    breadcrumbInit();
  }

  void breadcrumbInit() {}

  @override
  ngAfterViewInit() async {
  }
}