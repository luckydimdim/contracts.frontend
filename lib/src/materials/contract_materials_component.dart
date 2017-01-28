import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';
import 'package:grid/JsObjectConverter.dart';
import 'package:grid/jq_grid.dart';

@Component(selector: 'contract-works',
    templateUrl: 'contract_materials_component.html')
class ContractMaterialsComponent implements OnInit, OnDestroy {
  static const String route_name = 'ContractMaterials';
  static const String route_path = 'materials';
  static const Route route = const Route(
      path: ContractMaterialsComponent.route_path,
      component: ContractMaterialsComponent,
      name: ContractMaterialsComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;
  jqGrid _worksGrid;

  ContractMaterialsComponent(this._router, this._resourcesLoaderService) {}

  @override
  void ngOnInit() {
    materialsGridInit();
  }

  @override
  void ngOnDestroy() {

  }

  Future materialsGridInit() async {
    var columns = new List<Column>();

    columns.add(new Column()
      ..dataField = 'Code'
      .. text = 'Код'
      .. width = '100px'
      .. pinned = true);
    columns.add(new Column()
      ..dataField = 'Name'
      ..text = 'Наименование материалов'
      ..pinned = true);

    columns.add(new Column()
      ..dataField = 'Unit'
      .. text = 'Ед. изм.');
    columns.add(new Column()
      ..dataField = 'Amount'
      .. text = 'Количество');
    columns.add(new Column()
      ..dataField = 'Currency'
      .. text = 'Валюта');
    columns.add(new Column()
      ..dataField = 'ObjectConstruction'
      .. text = 'Объект строительства');
    columns.add(new Column()
      ..dataField = 'Cost'
      .. text = 'Стоимость');
    columns.add(new Column()
      ..dataField = 'DeliveryDate'
      .. text = 'Дата поставки');

    var hierarchy = new Hierarchy()
      ..root = 'children';

    var source = new SourceOptions()
      ..url = '//cm-ylng-msk-01/cmas-backend/api/contract/1/materials'
      ..id = 'recid'
      ..hierarchy = hierarchy
      ..dataType = 'json';

    var options = new GridOptions()
      ..checkboxes = false
      ..source = source
      ..columns = columns;


    _worksGrid = new jqGrid(this._resourcesLoaderService, "#materialsGrid",
        JsObjectConverter.convert(options));

    await _worksGrid.Init();
  }


}
