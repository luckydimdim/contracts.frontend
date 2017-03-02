import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

/*import 'package:contract_list/contract_list_component.dart';*/
/*import 'package:contract_view/contract_view_component.dart';*/
/*import 'package:contract_create/contract_create_component.dart';*/
import 'contract_list.frontend/contract_list_component.dart';
import 'contract_view.frontend/contract_view_component.dart';
import 'contract_create.frontend/contract_create_component.dart';

@Component(
    selector: 'contracts',
    templateUrl: 'contracts_component.html',
    directives: const [RouterOutlet])
@RouteConfig(const [
  const Route(
      path: '',
      component: ContractListComponent,
      name: 'ContractList',
      useAsDefault: true,
      data: ContractListComponent.DisplayName),
  const Route(
      path: '/create',
      component: ContractCreateComponent,
      name: 'ContractCreate',
      data: ContractCreateComponent.DisplayName),
  const Route(
      path: '/:id/...',
      component: ContractViewComponent,
      name: 'Contract',
      data: ContractViewComponent.DisplayName)
])
class ContractsComponent {}
