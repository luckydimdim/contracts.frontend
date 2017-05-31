import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:master_layout/breadcrumb_service.dart';

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

import 'general/contract_general_model.dart';
import '../contracts_service/contracts_service.dart';

@Component(
    selector: 'contract',
    templateUrl: 'contract_component.html',
    directives: const [RouterOutlet, ContractLayoutComponent],
    providers: [ContractsService])
@RouteConfig(const [
  const Route(
      path: 'general',
      component: ContractGeneralComponent,
      name: 'ContractGeneral',
      data: const {'displayName': ContractGeneralComponent.DisplayName},
      useAsDefault: true),
  const Route(
      path: 'works',
      component: ContractWorksComponent,
      data: ContractWorksComponent.DisplayName,
      name: 'ContractWorks'),
  ContractDocSettingsComponent.route,
  ContractMaterialsComponent.route,
  ContractPaymentsComponent.route,
  WorksToBudgetBindingComponent.route,
  ContractPaymentsScheduleComponent.route,
  WorksToTitleBindingComponent.route,
  MaterialsToBudgetBindingComponent.route,
  MaterialsToTitleBindingComponent.route,
  ContractBudgetComponent.route
])
class ContractComponent implements OnInit {
  final Router _router;
  static const DisplayName = 'Договор';
  static const DisplayNameOnCreate = 'Создание договора';
  final ContractsService service;
  final BreadcrumbService _breadcrumbService;

  ContractComponent(this._router, this._breadcrumbService, this.service,
      RouteData routeData, RouteParams routeParams) {
    if (routeData.get('creatingMode') == true)
      service.creatingMode = true;
    else {
      service.creatingMode = false;
      service.contractId = routeParams.get('id');
    }
  }

  @override
  Future ngOnInit() async {
    if (!service.creatingMode) {
      service.model = await service.general.getContract(service.contractId);
      breadcrumbInit();
    } else {
      service.model = new ContractGeneralModel();
      service.writeEnabled = true;
    }
  }

  void breadcrumbInit() {
    var displayName = 'Договор №${service.model.number}';
    _breadcrumbService.changeDisplayName(this.runtimeType, displayName);
  }
}
