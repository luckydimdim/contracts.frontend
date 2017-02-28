import 'dart:core';

import 'package:angular2/platform/browser.dart';
import 'package:angular2/core.dart';
import 'package:angular2/src/core/reflection/reflection.dart';
import 'package:angular2/router.dart';
import 'package:angular2/src/platform/browser/location/hash_location_strategy.dart';
import 'package:angular2/platform/common.dart';

import 'package:alert/alert_service.dart';
import 'package:angular_utils/cm_router_link.dart';
import 'package:resources_loader/resources_loader.dart';

import 'package:master_layout/master_layout_component.dart';
import 'package:contracts/contracts_component.dart';

bool get isDebug =>
    (const String.fromEnvironment('PRODUCTION', defaultValue: 'false')) !=
        'true';

@Component(
    selector: 'app',
    providers: const [
      ROUTER_PROVIDERS,
      const Provider(LocationStrategy, useClass: HashLocationStrategy)
    ])
@View(
    template: '<master-layout><contracts></contracts></master-layout>',
    directives: const [
      MasterLayoutComponent, ContractsComponent, RouterOutlet, CmRouterLink])
@RouteConfig(const [const Route(
    path: '...', component: ContractsComponent, name: 'Contracts', useAsDefault: true)
])
class AppComponent {}

main() async {
  if (isDebug) {
    reflector.trackUsage();
  }

  ComponentRef ref = await bootstrap(AppComponent, [
    ROUTER_PROVIDERS,
    const Provider(LocationStrategy, useClass: HashLocationStrategy),
    const Provider(ResourcesLoaderService),
    const Provider(AlertService)
  ]);

  if (isDebug) {
    print('Application in DebugMode');
    enableDebugTools(ref);
    print('Unused keys: ${reflector.listUnusedKeys()}');
  }
}