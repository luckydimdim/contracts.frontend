import 'dart:core';

import 'package:angular2/platform/browser.dart';
import 'package:angular2/core.dart';
import 'package:angular2/src/core/reflection/reflection.dart';
import 'package:angular2/router.dart';
import 'package:angular2/src/platform/browser/location/hash_location_strategy.dart';
import 'package:angular2/platform/common.dart';

import 'package:angular_utils/cm_router_link.dart';
import 'package:contract/contract_component.dart';
import 'package:contract/src/contract_budget/contract_budget_component.dart';
import 'package:contract/src/doc_settings/contract_doc_settings_component.dart';
import 'package:contract/src/general/contract_general_component.dart';
import 'package:contract/src/materials/contract_materials_component.dart';
import 'package:contract/src/materials_to_budget_binding/materials_to_budget_binding_component.dart';
import 'package:contract/src/materials_to_title_binding/materials_to_title_binding_component.dart';
import 'package:contract/src/payments/contract_payments_component.dart';
import 'package:contract/src/payments_schedule/contract_payments_schedule_component.dart';
import 'package:contract/src/works/contract_works_component.dart';
import 'package:contract/src/works_to_budget_binding/works_to_budget_binding_component.dart';
import 'package:contract/src/works_to_title_binding/works_to_title_binding_component.dart';
import 'package:resources_loader/resources_loader.dart';

import 'package:master_layout/master_layout_component.dart';

bool get isDebug =>
    (const String.fromEnvironment('PRODUCTION', defaultValue: 'false')) != 'true';

@Component(
  selector: 'app',
  providers: const [
    ROUTER_PROVIDERS,
    const Provider(LocationStrategy, useClass: HashLocationStrategy)])
@View(
  template: '<master-layout><contract></contract></master-layout>',
  directives: const [MasterLayoutComponent, ContractComponent, RouterOutlet, CmRouterLink])
@RouteConfig(const [
  ContractComponent.route,
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
  ContractBudgetComponent.route])
class AppComponent {}

main() async {
  if (isDebug) {
    reflector.trackUsage();
  }

  ComponentRef ref = await bootstrap(AppComponent, [
    ROUTER_PROVIDERS,
    const Provider(LocationStrategy, useClass: HashLocationStrategy),
    const Provider(ResourcesLoaderService)]);

  if (isDebug) {
    print('Application in DebugMode');
    enableDebugTools(ref);
    print('Unused keys: ${reflector.listUnusedKeys()}');
  }
}