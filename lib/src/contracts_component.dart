import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'contract_list/contract_list_component.dart';
import 'contract/contract_component.dart';
import 'package:contracts/src/contract/general/contract_general_service.dart';
import 'package:contracts/src/contracts_service/contracts_service.dart';

@Component(
    selector: 'contracts',
    templateUrl: 'contracts_component.html',
    directives: const [RouterOutlet],
    providers: const [RouteParams, ContractGeneralService])
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
      data: const {'displayName': ContractComponent.DisplayName}),
  const Route(
      path: '/create/...',
      component: ContractComponent,
      name: 'ContractCreate',
      data: const {'displayName': ContractComponent.DisplayNameOnCreate, 'creatingMode': true})
])
class ContractsComponent {
  static const DisplayName = const {'displayName': 'Договоры'};
}
