import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';
import 'package:grid/JsObjectConverter.dart';
import 'package:grid/jq_grid.dart';

@Component(
    selector: 'materials-to-title-binding',
    templateUrl: 'materials_to_title_binding_component.html')
class MaterialsToTitleBindingComponent implements OnInit, OnDestroy {
  static const String route_name = 'MaterialsToTitleBinding';
  static const String route_path = 'materials/titleBinding';
  static const Route route = const Route(
      path: MaterialsToTitleBindingComponent.route_path,
      component: MaterialsToTitleBindingComponent,
      name: MaterialsToTitleBindingComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  MaterialsToTitleBindingComponent(this._router, this._resourcesLoaderService) {}

  @override
  void ngOnInit() {
    MaterialsGridInit();
    TitleGridInit();
  }

  @override
  void ngOnDestroy() {}

  Future MaterialsGridInit() async {
    var columns = new List<Column>();

    columns.add(new Column()
      ..dataField = 'Name'
      ..text = 'Наименование этапа/работы');

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
      ..height = null
      ..columns = columns;

    var grid = new jqGrid(this._resourcesLoaderService, "#materialsGrid",
        JsObjectConverter.convert(options));
    await grid.Init();
  }

  Future TitleGridInit() async {
    var columns = new List<Column>();


    columns.add(new Column()
      ..dataField = 'TitleName'
      ..text = 'Наименование статьи/подстатьи титульного списка');


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
      ..height = null
      ..columns = columns;

    var grid = new jqGrid(this._resourcesLoaderService, "#titleGrid",
        JsObjectConverter.convert(options));
    await grid.Init();
  }
}
