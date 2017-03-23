import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';

import 'contract_layout/contract_layout_component.dart';
import 'general/contract_general_component.dart';
import 'doc_settings/contract_doc_settings_component.dart';
import 'materials/contract_materials_component.dart';
import 'payments/contract_payments_component.dart';
import 'payments_schedule/contract_payments_schedule_component.dart';
import 'works/contract_works_component.dart';
import 'works_to_budget_binding/works_to_budget_binding_component.dart';
import 'works_to_title_binding/works_to_title_binding_component.dart';
import 'materials_to_budget_binding/materials_to_budget_binding_component.dart';
import 'materials_to_title_binding/materials_to_title_binding_component.dart';
import 'contract_budget/contract_budget_component.dart';

@Component(
    selector: 'contract',
    templateUrl: 'contract_component.html',
    directives: const [RouterOutlet, ContractLayoutComponent])
@RouteConfig(const [
  ContractGeneralComponent.route,
  ContractDocSettingsComponent.route,
  ContractMaterialsComponent.route,
  ContractPaymentsComponent.route,
  WorksToBudgetBindingComponent.route,
  ContractPaymentsScheduleComponent.route,
  WorksToTitleBindingComponent.route,
  MaterialsToBudgetBindingComponent.route,
  MaterialsToTitleBindingComponent.route,
  ContractWorksComponent.route,
  ContractBudgetComponent.route
])
class ContractComponent implements OnInit {
  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;
  static const DisplayName = const {'displayName': 'Договор'};
  final RouteParams _routeParams;

  ContractComponent(
      this._router, this._resourcesLoaderService, this._routeParams) {}

  @override
  void ngOnInit() {
    breadcrumbInit();
  }

  void breadcrumbInit() {}
}
