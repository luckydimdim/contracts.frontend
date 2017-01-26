import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';
import 'package:grid/grid.dart';

@Component(selector: 'contract-works', templateUrl: 'contract_materials_component.html')
class ContractMaterialsComponent implements OnInit, OnDestroy {
  static const String route_name = 'ContractMaterials';
  static const String route_path = 'materials';
  static const Route route = const Route(
      path: ContractMaterialsComponent.route_path,
      component: ContractMaterialsComponent,
      name: ContractMaterialsComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;
  Grid _materialsGrid;

  ContractMaterialsComponent(this._router, this._resourcesLoaderService) {}

  @override
  void ngOnInit() {
    materialsGridInit();
  }

  @override
  void ngOnDestroy() {
    if (_materialsGrid != null)
     _materialsGrid.Destroy();

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
      ..url=' //cm-ylng-msk-01/cmas-backend/api/contract/1/materials'
      ..method='GET';

    _materialsGrid = new Grid(this._resourcesLoaderService, "#materialsGrid", options);
  }


}
