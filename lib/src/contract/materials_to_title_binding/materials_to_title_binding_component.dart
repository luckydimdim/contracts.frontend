import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'materials-to-title-binding',
    templateUrl: 'materials_to_title_binding_component.html',
    styleUrls: const ['materials_to_title_binding_component.css'],
    encapsulation: ViewEncapsulation.None)
class MaterialsToTitleBindingComponent implements OnInit, OnDestroy {
  static const String route_name = 'MaterialsToTitleBinding';
  static const String route_path = 'materials/titleBinding';
  static const Route route = const Route(
      path: MaterialsToTitleBindingComponent.route_path,
      component: MaterialsToTitleBindingComponent,
      name: MaterialsToTitleBindingComponent.route_name);

  MaterialsToTitleBindingComponent();

  @override
  void ngOnInit() {
    breadcrumbInit();
  }

  void breadcrumbInit() {}

  @override
  void ngOnDestroy() {}
}
