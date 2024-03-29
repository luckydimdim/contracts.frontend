import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'materials-to-budget-binding',
    templateUrl: 'materials_to_budget_binding_component.html',
    styleUrls: const ['materials_to_budget_binding_component.css'],
    encapsulation: ViewEncapsulation.None)
class MaterialsToBudgetBindingComponent implements OnInit, OnDestroy {
  static const String route_name = 'MaterialsToBudgetBinding';
  static const String route_path = 'materials/budgetBinding';
  static const Route route = const Route(
      path: MaterialsToBudgetBindingComponent.route_path,
      component: MaterialsToBudgetBindingComponent,
      name: MaterialsToBudgetBindingComponent.route_name);

  MaterialsToBudgetBindingComponent();

  @override
  void ngOnInit() {
    breadcrumbInit();
  }

  // import 'dart:html';
  void breadcrumbInit() {}

  @override
  void ngOnDestroy() {}
}
