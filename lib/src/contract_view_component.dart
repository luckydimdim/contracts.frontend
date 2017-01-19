import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'contract-view',
    templateUrl: 'contract_view_component.html')
class ContractViewComponent implements OnInit {
  static const String route_name = "ContractView";
  static const String route_path = "contractView";
  static const Route route = const Route(
      path: ContractViewComponent.route_path,
      component: ContractViewComponent,
      name: ContractViewComponent.route_name);

  final Router _router;

  ContractViewComponent(this._router) {}

  @override
  void ngOnInit() {}

  onSubmit() {}
}
