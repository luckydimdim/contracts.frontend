import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:resources_loader/resources_loader.dart';

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

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  ContractMaterialsComponent(this._router, this._resourcesLoaderService) {}

  @override
  void ngOnInit() {
    breadcrumbInit();
  }

  // import 'dart:html';
  void breadcrumbInit() {}

  @override
  void ngOnDestroy() {}
}
