import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:js/js_util.dart';
import 'package:js/js.dart';
import 'dart:html';
import 'package:resources_loader/resources_loader.dart';
import 'package:grid/JsObjectConverter.dart';
import 'package:grid/jq_grid.dart';

@Component(
    selector: 'materials-to-title-binding',
    templateUrl: 'materials_to_title_binding_component.html',
    styleUrls: const ['materials_to_title_binding_component.css'],
    encapsulation: ViewEncapsulation.None)
class MaterialsToTitleBindingComponent implements OnInit, OnDestroy {
  static const String route_name = 'MaterialsToTitleBinding';
  static const String route_path = 'materials/titleBinding';
  static const Route route = const Route(
      path: MaterialsToTitleBindingComponent.route_path,
      component: MaterialsToTitleBindingComponent,
      name: MaterialsToTitleBindingComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  MaterialsToTitleBindingComponent(
      this._router, this._resourcesLoaderService) {}

  @override
  void ngOnInit() {
    breadcrumbInit();
    MaterialsGridInit();
    TitleGridInit();
  }

  // import 'dart:html';
  void breadcrumbInit() {}

  @override
  void ngOnDestroy() {}

  String titleRender(dynamic row, dynamic dataField, dynamic cellValue,
      dynamic rowData, dynamic cellText) {
    var icon = '';

    if (getProperty(rowData, 'Type') == 'material')
      icon = '<i class="fa fa-cubes"></i>&nbsp';

    var percent = '';
    if (hasProperty(rowData, 'Percent') == true) {
      percent = getProperty(rowData, 'Percent');
      percent = '<span class="text-muted small">($percent%)</span>';
    }

    return '$icon $cellValue $percent';
  }

  String materialsRender(dynamic row, dynamic dataField, dynamic cellValue,
      dynamic rowData, dynamic cellText) {
    var _class = '';
    var percent = '';

    if (hasProperty(rowData, 'Binded') == true &&
        getProperty(rowData, 'Binded') == 'true') {
      _class = 'is-hidden';
    }

    if (hasProperty(rowData, 'Percent')) {
      percent = getProperty(rowData, 'Percent');
      percent = '<span class="text-muted small">($percent%)</span>';
    }

    return '<span class="$_class">$cellValue $percent</span>';
  }

  Future MaterialsGridInit() async {
    var columns = new List<Column>();

    columns.add(new Column()
      ..dataField = 'Name'
      ..cellsRenderer = allowInterop(materialsRender)
      ..text = 'Наименование этапа/работы');

    var hierarchy = new Hierarchy()..root = 'children';

    var source = new SourceOptions()
      ..url =
          'packages/contract/src/materials_to_title_binding/materials_to_title_binding_left.json'
      ..id = 'recid'
      ..hierarchy = hierarchy
      ..dataType = 'json';

    var options = new GridOptions()
      ..checkboxes = false
      ..source = source
      ..editable = false
      ..height = null
      ..columns = columns;

    var grid = new jqGrid(this._resourcesLoaderService, "#materialsGrid",
        JsObjectConverter.convert(options));
    await grid.Init();
  }

  Future TitleGridInit() async {
    var columns = new List<Column>();

    columns.add(new Column()
      ..dataField = 'Name'
      ..cellsRenderer = allowInterop(titleRender)
      ..text = 'Наименование статьи/подстатьи титульного списка');

    var hierarchy = new Hierarchy()..root = 'children';

    var source = new SourceOptions()
      ..url =
          'packages/contract/src/materials_to_title_binding/materials_to_title_binding_right.json'
      ..id = 'recid'
      ..hierarchy = hierarchy
      ..dataType = 'json';

    var options = new GridOptions()
      ..checkboxes = false
      ..source = source
      ..height = null
      ..editable = false
      ..columns = columns;

    var grid = new jqGrid(this._resourcesLoaderService, "#titleGrid",
        JsObjectConverter.convert(options));
    await grid.Init();
  }
}
