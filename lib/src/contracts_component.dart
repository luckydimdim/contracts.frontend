import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'contract_list.frontend/contract_list_component.dart';
import 'contract.frontend/contract_component.dart';
import 'contract.frontend/src/general/contract_general_create_component.dart';

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
      path: '/:id/...',
      component: ContractComponent,
      name: 'Contract',
      data: ContractComponent.DisplayName),
 const Route(
      path: '/create/',
      component: ContractGeneralCreateComponent,
      name: 'ContractCreate',
      data: ContractComponent.DisplayName)
])
class ContractsComponent {}
