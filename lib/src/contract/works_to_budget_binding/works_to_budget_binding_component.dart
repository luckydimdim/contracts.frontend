import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:js/js_util.dart';
import 'package:js/js.dart';
import 'package:resources_loader/resources_loader.dart';
import 'package:grid/JsObjectConverter.dart';
import 'package:grid/jq_grid.dart';
import 'dart:html';

@Component(
    selector: 'works-to-budget-binding',
    templateUrl: 'works_to_budget_binding_component.html',
    styleUrls: const ['works_to_budget_binding_component.css'],
    encapsulation: ViewEncapsulation.None)
class WorksToBudgetBindingComponent implements OnInit, OnDestroy {
  static const String route_name = 'WorksToBudgetBinding';
  static const String route_path = 'works/budget-binding';
  static const Route route = const Route(
      path: WorksToBudgetBindingComponent.route_path,
      component: WorksToBudgetBindingComponent,
      name: WorksToBudgetBindingComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  WorksToBudgetBindingComponent(this._router, this._resourcesLoaderService) {}

  // import 'dart:html';
  void breadcrumbInit() {}

  @override
  void ngOnInit() {
    breadcrumbInit();
    WorksGridInit();
    BudgetGridInit();
  }

  @override
  void ngOnDestroy() {}

  String budgetRender(dynamic row, dynamic dataField, dynamic cellValue,
      dynamic rowData, dynamic cellText) {
    var icon = '';

    if (getProperty(rowData, 'Type') == 'work')
      icon = '<i class="fa fa-wrench"></i>&nbsp';

    var percent = '';
    if (hasProperty(rowData, 'Percent') == true) {
      percent = getProperty(rowData, 'Percent');
      percent = '<span class="text-muted small">($percent%)</span>';
    }

    return '$icon $cellValue $percent';
  }

  String worksRender(dynamic row, dynamic dataField, dynamic cellValue,
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

  Future WorksGridInit() async {
    var columns = new List<Column>();

    columns.add(new Column()
      ..dataField = 'Name'
      ..text = 'Наименование этапа/работы'
      ..cellsRenderer = allowInterop(worksRender));

    var hierarchy = new Hierarchy()..root = 'children';

    var source = new SourceOptions()
      ..url =
          'packages/contract/src/works_to_budget_binding/works_to_budget_binding_left.json'
      ..id = 'recid'
      ..hierarchy = hierarchy
      ..dataType = 'json';

    var options = new GridOptions()
      ..checkboxes = false
      ..source = source
      ..editable = false
      ..height = null
      ..columns = columns;

    var grid = new jqGrid(this._resourcesLoaderService, "#worksGrid",
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
          'packages/contract/src/works_to_budget_binding/works_to_budget_binding_right.json'
      ..id = 'recid'
      ..hierarchy = hierarchy
      ..dataType = 'json';

    var options = new GridOptions()
      ..checkboxes = false
      ..editable = false
      ..source = source
      ..height = null
      ..columns = columns;

    var grid = new jqGrid(this._resourcesLoaderService, "#bidgetGrid",
        JsObjectConverter.convert(options));
    await grid.Init();
  }
}
