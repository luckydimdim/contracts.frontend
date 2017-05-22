import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'works-to-title-binding',
    templateUrl: 'works_to_title_binding_component.html',
    styleUrls: const ['works_to_title_binding_component.css'],
    encapsulation: ViewEncapsulation.None)
class WorksToTitleBindingComponent implements OnInit, OnDestroy {
  static const String route_name = 'WorksToTitleBinding';
  static const String route_path = 'works/title-binding';
  static const Route route = const Route(
      path: WorksToTitleBindingComponent.route_path,
      component: WorksToTitleBindingComponent,
      name: WorksToTitleBindingComponent.route_name);

  WorksToTitleBindingComponent();

  void breadcrumbInit() {}

  @override
  void ngOnInit() {
    breadcrumbInit();
  }

  @override
  void ngOnDestroy() {}
}
