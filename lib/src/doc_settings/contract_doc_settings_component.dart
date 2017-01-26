import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';


@Component(selector: 'contract-doc-settings', templateUrl: 'contract_doc_settings_component.html')
class ContractDocSettingsComponent  {
  static const String route_name = 'ContractDocSettings';
  static const String route_path = 'docsettings';
  static const Route route = const Route(
      path: ContractDocSettingsComponent.route_path,
      component: ContractDocSettingsComponent,
      name: ContractDocSettingsComponent.route_name);

  final Router _router;


  ContractDocSettingsComponent(this._router) {}



}
