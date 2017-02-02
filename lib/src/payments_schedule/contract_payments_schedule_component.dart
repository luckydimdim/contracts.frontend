import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'dart:html';

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

  // import 'dart:html';
  void breadcrumbInit(){
    var  breadcrumbContent = querySelector('#breadcrumbContent') as DivElement;

    if (breadcrumbContent == null)
      return;

    breadcrumbContent.innerHtml = '''
            <li class="breadcrumb-item"><a href="#/master/dashboard">Главная</a></li>
            <li class="breadcrumb-item"><a href="#/master/contractList">Список договоров</a></li>
            <li class="breadcrumb-item"><a href="#/master/contract">Договор 644/15-ЯСПГ</a></li>
            <li class="breadcrumb-item active">График платежей</li>
    ''';
  }

  @override
  void ngOnInit() {
    breadcrumbInit();
  }
}
