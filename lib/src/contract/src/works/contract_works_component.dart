import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:resources_loader/resources_loader.dart';
@Component(
    selector: 'contract-works', templateUrl: 'contract_works_component.html')
class ContractWorksComponent implements OnInit, OnDestroy {
  static const String route_name = 'ContractWorks';
  static const String route_path = 'works';
  static const Route route = const Route(
      path: ContractWorksComponent.route_path,
      component: ContractWorksComponent,
      name: ContractWorksComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  ContractWorksComponent(this._router, this._resourcesLoaderService) {}

  void breadcrumbInit() {}

  @override
  void ngOnInit() {
    breadcrumbInit();
  }

  @override
  void ngOnDestroy() {}

 }
