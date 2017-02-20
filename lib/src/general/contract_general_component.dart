import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'contract-general',
    templateUrl: 'contract_general_component.html')
class ContractGeneralComponent implements OnInit {
  static const String route_name = 'ContractGeneral';
  static const String route_path = 'general';
  static const Route route = const Route(
      path: ContractGeneralComponent.route_path,
      component: ContractGeneralComponent,
      name: ContractGeneralComponent.route_name,
      useAsDefault: true);

  final Router _router;

  ContractGeneralComponent(this._router) {}

  @override
  void ngOnInit() {
    breadcrumbInit();
  }

  void breadcrumbInit(){
    var  breadcrumbContent = querySelector('#breadcrumbContent') as OListElement;

    if (breadcrumbContent == null)
      return;

    breadcrumbContent.innerHtml = '''
            <li class="breadcrumb-item"><a href="#/master/dashboard">Главная</a></li>
            <li class="breadcrumb-item"><a href="#/master/contractList">Список договоров</a></li>
            <li class="breadcrumb-item"><a href="#/master/contract">Договор 644/15-ЯСПГ</a></li>
            <li class="breadcrumb-item active">Общая информация</li>
    ''';
  }
}
