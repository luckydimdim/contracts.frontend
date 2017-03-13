import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'contract-payments',
    templateUrl: 'contract_payments_component.html')
class ContractPaymentsComponent implements OnInit {
  static const String route_name = 'ContractPayments';
  static const String route_path = 'payments';
  static const Route route = const Route(
      path: ContractPaymentsComponent.route_path,
      component: ContractPaymentsComponent,
      name: ContractPaymentsComponent.route_name);

  final Router _router;

  ContractPaymentsComponent(this._router) {}

  // import 'dart:html';
  void breadcrumbInit() {}

  @override
  void ngOnInit() {
    breadcrumbInit();
  }
}
