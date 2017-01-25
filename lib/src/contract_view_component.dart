import 'dart:html';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';
import 'package:grid/grid.dart';

@Component(
    selector: 'contract-view', templateUrl: 'contract_view_component.html')
class ContractViewComponent implements OnInit, OnDestroy {
  static const String route_name = "ContractView";
  static const String route_path = "contractView";
  static const Route route = const Route(
      path: ContractViewComponent.route_path,
      component: ContractViewComponent,
      name: ContractViewComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  Grid _materialsGrid;
  Grid _worksGrid;

  ContractViewComponent(this._router, this._resourcesLoaderService) {
    print(this._router);
  }

  @override
  void ngOnInit() {
    this._resourcesLoaderService.loadScript('assets/','app.js', true);

    materialsGridInit();
    WorksGridInit();
  }

  @override
  void ngOnDestroy() {
    _materialsGrid.Destroy();
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
      ..url='http://localhost:5000/api/contract/1/works'
      ..method='GET';

    _worksGrid = new Grid(this._resourcesLoaderService, "#worksGrid", options);
  }

  void materialsGridInit(){

    var columns = new List<Column>();

    columns.add(new Column(field: 'Code', caption: 'Код', size: '100px', frozen: true));
    columns.add(new Column(field: 'Name', caption: 'Наименование материалов', size: '300px', frozen: true));

    columns.add(new Column(field: 'Unit', caption: 'Ед. изм.', size: '100px'));
    columns.add(new Column(field: 'Amount', caption: 'Количество', size: '100px'));
    columns.add(new Column(field: 'Currency', caption: 'Валюта', size: '100px'));
    columns.add(new Column(field: 'ObjectConstruction', caption: 'Объект строительства', size: '200px'));
    columns.add(new Column(field: 'Cost', caption: 'Стоимость', size: '100px'));
    columns.add(new Column(field: 'DeliveryDate', caption: 'Дата поставки', size: '150px', render: 'date'));

    var options = new GridOptions()
      ..name = 'materialsGrid'
      ..columns = columns
      ..url='http://localhost:5000/api/contract/1/materials'
      ..method='GET';

    _materialsGrid = new Grid(this._resourcesLoaderService, "#materialsGrid", options);
  }


  onSubmit() {}
}
