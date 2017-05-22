import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'contract-works',
    templateUrl: 'contract_materials_component.html')
class ContractMaterialsComponent implements OnInit, OnDestroy {
  static const String route_name = 'ContractMaterials';
  static const String route_path = 'materials';
  static const Route route = const Route(
      path: ContractMaterialsComponent.route_path,
      component: ContractMaterialsComponent,
      name: ContractMaterialsComponent.route_name);

  ContractMaterialsComponent();

  @override
  void ngOnInit() {
    breadcrumbInit();
  }

  // import 'dart:html';
  void breadcrumbInit() {}

  @override
  void ngOnDestroy() {}
}
