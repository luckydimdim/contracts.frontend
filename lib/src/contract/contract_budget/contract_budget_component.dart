import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(selector: 'contract-budget')
@View(
    templateUrl: 'contract_budget_component.html',
    directives: const [RouterLink])
class ContractBudgetComponent {
  static const String route_name = "ContractBudget";
  static const String route_path = "contract-budget";
  static const Route route = const Route(
      path: ContractBudgetComponent.route_path,
      component: ContractBudgetComponent,
      name: ContractBudgetComponent.route_name);

  bool budgetExist = true;

  ContractBudgetComponent();

  void render(dynamic e) {}
}
