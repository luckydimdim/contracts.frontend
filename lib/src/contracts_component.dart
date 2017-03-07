import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'contract_list.frontend/contract_list_component.dart';
import 'contract.frontend/contract_component.dart';
import 'package:contracts/src/contract.frontend/src/general/contract_general_service.dart';
import 'package:contracts/src/contracts_service/contracts_service.dart';

@Component(
    selector: 'contracts',
    templateUrl: 'contracts_component.html',
    directives: const [RouterOutlet],
    providers: const[RouteParams, ContractsService, ContractGeneralService])
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
      data: ContractComponent.DisplayName)
])
class ContractsComponent {}
