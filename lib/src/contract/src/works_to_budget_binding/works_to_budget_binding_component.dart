import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:resources_loader/resources_loader.dart';

@Component(
    selector: 'works-to-budget-binding',
    templateUrl: 'works_to_budget_binding_component.html',
    styleUrls: const ['works_to_budget_binding_component.css'],
    encapsulation: ViewEncapsulation.None)
class WorksToBudgetBindingComponent implements OnInit, OnDestroy {
  static const String route_name = 'WorksToBudgetBinding';
  static const String route_path = 'works/budget-binding';
  static const Route route = const Route(
      path: WorksToBudgetBindingComponent.route_path,
      component: WorksToBudgetBindingComponent,
      name: WorksToBudgetBindingComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  WorksToBudgetBindingComponent(this._router, this._resourcesLoaderService) {}

  void breadcrumbInit() {}

  @override
  void ngOnInit() {
    breadcrumbInit();
  }

  @override
  void ngOnDestroy() {}
}
