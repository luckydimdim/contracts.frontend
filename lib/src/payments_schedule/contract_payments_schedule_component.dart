import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'contract-payments-schedule',
    templateUrl: 'contract_payments_schedule_component.html')
class ContractPaymentsScheduleComponent implements OnInit {
  static const String route_name = 'ContractPaymentsSchedule';
  static const String route_path = 'payments-schedule';
  static const Route route = const Route(
      path: ContractPaymentsScheduleComponent.route_path,
      component: ContractPaymentsScheduleComponent,
      name: ContractPaymentsScheduleComponent.route_name);

  final Router _router;

  ContractPaymentsScheduleComponent(this._router) {}

  @override
  void ngOnInit() {}
}
