import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(selector: 'contract-create')
@View(
    templateUrl: 'contract_create_component.html', directives: const [RouterLink])
class ContractCreateComponent {
  static const DisplayName = const {'displayName': 'Создание договора'};

  ContractCreateComponent() {}
}