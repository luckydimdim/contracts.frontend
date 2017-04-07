import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';
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
    directives: const [RouterOutlet, ContractLayoutComponent])
@RouteConfig(const [
  const Route(
      path: 'general',
      component: ContractGeneralComponent,
      name: 'ContractGeneral',
      data: ContractGeneralComponent.DisplayName,
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
  final ResourcesLoaderService _resourcesLoaderService;
  static const DisplayName = const {'displayName': 'Договор'};
  final RouteParams _routeParams;
  final ContractsService service;
  final BreadcrumbService _breadcrumbService;

  // FIXME: Использовать модель, предназначенную для этого компонента
  ContractGeneralModel model = null;

  String contractId;

  ContractComponent(this._router, this._resourcesLoaderService,
      this._routeParams, this._breadcrumbService, this.service) {}

  @override
  Future ngOnInit() async {
    Instruction ci = _router.parent.currentInstruction;
    contractId = ci.component.params['id'];

    model = await service.general.getContract(contractId);

    breadcrumbInit();

    return null;
  }

  void breadcrumbInit() {
    var displayName = 'Договор №${model.number}';
    _breadcrumbService.changeDisplayName(this.runtimeType, displayName);
  }
}
