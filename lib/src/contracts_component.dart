import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:contracts/contract_list_component.dart';
import 'package:contracts/contract_component.dart';

@Component(
    selector: 'contracts',
    templateUrl: 'contracts_component.html',
    directives: const [RouterOutlet])
@RouteConfig(const [const Route(
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
class ContractsComponent {
}
