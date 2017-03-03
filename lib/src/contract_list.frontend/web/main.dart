import 'dart:core';

import 'package:angular2/platform/browser.dart';
import 'package:angular2/core.dart';
import 'package:angular2/src/core/reflection/reflection.dart';
import 'package:angular2/router.dart';
import 'package:angular2/src/platform/browser/location/hash_location_strategy.dart';
import 'package:angular2/platform/common.dart';

import 'package:angular_utils/cm_router_link.dart';
import 'package:http/browser_client.dart';

import 'package:master_layout/master_layout_component.dart';

import 'package:config/config_service.dart';
import 'package:logger/logger_service.dart';

bool get isDebug =>
    (const String.fromEnvironment('PRODUCTION', defaultValue: 'false')) !=
    'true';

@Component(selector: 'app', providers: const [
  ROUTER_PROVIDERS,
  const Provider(LocationStrategy, useClass: HashLocationStrategy)
])
@View(
    template: '<master-layout><contracts></contracts></master-layout>',
    directives: const [
      MasterLayoutComponent,
      RouterOutlet,
      CmRouterLink
    ])
class AppComponent {}

main() async {
  if (isDebug) {
    reflector.trackUsage();
  }

  ComponentRef ref = await bootstrap(AppComponent, [
    ROUTER_PROVIDERS,
    const Provider(LocationStrategy, useClass: HashLocationStrategy),
    provide(BrowserClient, useFactory: () => new BrowserClient(), deps: []),
    const Provider(LoggerService),
    const Provider(ConfigService),
  ]);

  if (isDebug) {
    print('Application in DebugMode');
    enableDebugTools(ref);
    print('Unused keys: ${reflector.listUnusedKeys()}');
  }
}