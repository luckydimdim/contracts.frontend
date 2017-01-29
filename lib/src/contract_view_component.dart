import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';
import 'general/contract_general_component.dart';
import 'doc_settings/contract_doc_settings_component.dart';
import 'materials/contract_materials_component.dart';
import 'payments/contract_payments_component.dart';
import 'works/contract_works_component.dart';

@Component(
    selector: 'contract-view',
    templateUrl: 'contract_view_component.html',
    directives: const [RouterLink, RouterOutlet])
@RouteConfig(const [
  ContractDocSettingsComponent.route,
  ContractGeneralComponent.route,
  ContractMaterialsComponent.route,
  ContractPaymentsComponent.route,
  ContractWorksComponent.route
])
class ContractViewComponent implements OnInit {
  static const String route_name = "ContractView";
  static const String route_path = "contract/...";
  static const Route route = const Route(
      path: ContractViewComponent.route_path,
      component: ContractViewComponent,
      name: ContractViewComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  ContractViewComponent(this._router, this._resourcesLoaderService) {}

  @override
  void ngOnInit() {
    this._resourcesLoaderService.loadScript('assets/js/', 'app.js', true);
  }

  onSubmit() {}
}
