import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';
import 'package:grid/grid.dart';


@Component(selector: 'contract-works', templateUrl: 'contract_works_component.html')
class ContractWorksComponent implements OnInit, OnDestroy {
  static const String route_name = 'ContractWorks';
  static const String route_path = 'works';
  static const Route route = const Route(
      path: ContractWorksComponent.route_path,
      component: ContractWorksComponent,
      name: ContractWorksComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;
  Grid _worksGrid;

  ContractWorksComponent(this._router, this._resourcesLoaderService) {}

  @override
  void ngOnInit() {
    WorksGridInit();
  }

  @override
  void ngOnDestroy() {
    if (_worksGrid != null)
      _worksGrid.Destroy();

  }
  void WorksGridInit(){

    var columns = new List<Column>();

    columns.add(new Column(field: 'Code', caption: 'Код', size: '100px', frozen: true));
    columns.add(new Column(field: 'Name', caption: 'Наименование этапа/работы', size: '300px', frozen: true));

    columns.add(new Column(field: 'BeginDate', caption: 'Начало', size: '100px', render: 'date'));
    columns.add(new Column(field: 'EndDate', caption: 'Окончание', size: '100px', render: 'date'));
    columns.add(new Column(field: 'Unit', caption: 'Ед. изм.', size: '100px'));
    columns.add(new Column(field: 'Amount', caption: 'Объем', size: '100px'));
    columns.add(new Column(field: 'Cost', caption: 'Стоимость', size: '100px'));
    columns.add(new Column(field: 'Currency', caption: 'Валюта', size: '100px'));
    columns.add(new Column(field: 'ContractorName', caption: 'Исполнитель', size: '200px'));

    //columns.add(new Column(field: 'ObjectConstruction', caption: 'Объект строительства', size: '200px'));

    var options = new GridOptions()
      ..name = 'worksGrid'
      ..columns = columns
      //..url = ' //cm-ylng-msk-01/cmas-backend/api/contract/1/works'
      ..url = 'http://localhost:5000/api/contract/1/works'      
      ..method = 'GET';

    _worksGrid = new Grid(this._resourcesLoaderService, "#worksGrid", options);
  }


}
