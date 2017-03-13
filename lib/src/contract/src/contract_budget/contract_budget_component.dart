import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';

@Component(selector: 'contract-budget')
@View(
    templateUrl: 'contract_budget_component.html',
    directives: const [RouterLink])
class ContractBudgetComponent implements OnInit, OnDestroy {
  static const String route_name = "ContractBudget";
  static const String route_path = "contract-budget";
  static const Route route = const Route(
      path: ContractBudgetComponent.route_path,
      component: ContractBudgetComponent,
      name: ContractBudgetComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  /**
   * //cm-ylng-msk-01/cmas-backend
   * //localhost:5000
   */
  static const String _domain = "//cm-ylng-msk-01/cmas-backend";

  //static const String _domain = "http://localhost:5000";

  bool budgetExist = true;

  ContractBudgetComponent(this._router, this._resourcesLoaderService) {}

  void breadcrumbInit() {}

  @override
  void ngOnInit() {
    breadcrumbInit();

  }

  void render(dynamic e) {

  }


  @override
  void ngOnDestroy() {}
}