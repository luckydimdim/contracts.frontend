import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'contract-general',
    templateUrl: 'contract_general_component.html')
class ContractGeneralComponent implements OnInit {
  static const String route_name = 'ContractGeneral';
  static const String route_path = 'general';
  static const Route route = const Route(
      path: ContractGeneralComponent.route_path,
      component: ContractGeneralComponent,
      name: ContractGeneralComponent.route_name,
      useAsDefault: true);

  final Router _router;

  ContractGeneralComponent(this._router) {}

  @override
  void ngOnInit() {
    breadcrumbInit();
  }

  void breadcrumbInit(){
  }
}
