import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'dart:html';

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
  void breadcrumbInit(){
    var  breadcrumbContent = querySelector('#breadcrumbContent') as OListElement;

    if (breadcrumbContent == null)
      return;

    breadcrumbContent.innerHtml = '''
            <li class="breadcrumb-item"><a href="#/master/dashboard">Главная</a></li>
            <li class="breadcrumb-item"><a href="#/master/contractList">Список договоров</a></li>
            <li class="breadcrumb-item"><a href="#/master/contract">Договор 644/15-ЯСПГ</a></li>
            <li class="breadcrumb-item active">Условия оплаты</li>
    ''';
  }

  @override
  void ngOnInit() {
    breadcrumbInit();
  }
}
