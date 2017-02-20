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
    selector: 'materials-to-budget-binding',
    templateUrl: 'materials_to_budget_binding_component.html',
    styleUrls: const ['materials_to_budget_binding_component.css'],
    encapsulation: ViewEncapsulation.None)
class MaterialsToBudgetBindingComponent implements OnInit, OnDestroy {
  static const String route_name = 'MaterialsToBudgetBinding';
  static const String route_path = 'materials/budgetBinding';
  static const Route route = const Route(
      path: MaterialsToBudgetBindingComponent.route_path,
      component: MaterialsToBudgetBindingComponent,
      name: MaterialsToBudgetBindingComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  MaterialsToBudgetBindingComponent(
      this._router, this._resourcesLoaderService) {}

  @override
  void ngOnInit() {
    breadcrumbInit();
    MaterialsGridInit();
    BudgetGridInit();
  }

  // import 'dart:html';
  void breadcrumbInit(){
    var  breadcrumbContent = querySelector('#breadcrumbContent') as OListElement;

    if (breadcrumbContent == null)
      return;

    breadcrumbContent.innerHtml = '''
            <li class="breadcrumb-item"><a href="#/master/dashboard">Главная</a></li>
            <li class="breadcrumb-item"><a href="#/master/contractList">Список договоров</a></li>
            <li class="breadcrumb-item"><a href="#/master/contract">Договор 644/15-ЯСПГ</a></li>
            <li class="breadcrumb-item active">Связи c бюджетом</li>
    ''';
  }

  @override
  void ngOnDestroy() {}

  String budgetRender(dynamic row, dynamic dataField, dynamic cellValue,
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
      ..text = 'Наименование материала');

    var hierarchy = new Hierarchy()..root = 'children';

    var source = new SourceOptions()
      ..url =
          'packages/contract/src/materials_to_budget_binding/materials_to_budget_binding_left.json'
      ..id = 'recid'
      ..hierarchy = hierarchy
      ..dataType = 'json';

    var options = new GridOptions()
      ..checkboxes = false
      ..editable = false
      ..source = source
      ..height = null
      ..columns = columns;

    var grid = new jqGrid(this._resourcesLoaderService, "#materialsGrid",
        JsObjectConverter.convert(options));
    await grid.Init();
  }

  Future BudgetGridInit() async {
    var columns = new List<Column>();

    columns.add(new Column()
      ..dataField = 'Name'
      ..cellsRenderer = allowInterop(budgetRender)
      ..text = 'Наименование статьи/подстатьи бюджета');

    var hierarchy = new Hierarchy()..root = 'children';

    var source = new SourceOptions()
      ..url =
          'packages/contract/src/materials_to_budget_binding/materials_to_budget_binding_right.json'
      ..id = 'recid'
      ..hierarchy = hierarchy
      ..dataType = 'json';

    var options = new GridOptions()
      ..checkboxes = false
      ..source = source
      ..height = null
      ..editable = false
      ..columns = columns;

    var grid = new jqGrid(this._resourcesLoaderService, "#bidgetGrid",
        JsObjectConverter.convert(options));
    await grid.Init();
  }
}
