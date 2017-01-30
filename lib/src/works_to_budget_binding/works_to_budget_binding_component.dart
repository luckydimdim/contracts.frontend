import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';
import 'package:grid/JsObjectConverter.dart';
import 'package:grid/jq_grid.dart';

@Component(
    selector: 'works-to-budget-binding',
    templateUrl: 'works_to_budget_binding_component.html')
class WorksToBudgetBindingComponent implements OnInit, OnDestroy {
  static const String route_name = 'WorksToBudgetBinding';
  static const String route_path = 'works/budgetBinding';
  static const Route route = const Route(
      path: WorksToBudgetBindingComponent.route_path,
      component: WorksToBudgetBindingComponent,
      name: WorksToBudgetBindingComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  WorksToBudgetBindingComponent(this._router, this._resourcesLoaderService) {}

  @override
  void ngOnInit() {
    WorksGridInit();
    BudgetGridInit();
  }

  @override
  void ngOnDestroy() {}

  Future WorksGridInit() async {
    var columns = new List<Column>();

    columns.add(new Column()
      ..dataField = 'Name'
      ..text = 'Наименование этапа/работы');

    var hierarchy = new Hierarchy()
      ..root = 'children';

    var source = new SourceOptions()
      ..url = '//cm-ylng-msk-01/cmas-backend/api/contract/1/works'
      ..id = 'recid'
      ..hierarchy = hierarchy
      ..dataType = 'json';

    var options = new GridOptions()
      ..checkboxes = false
      ..source = source
      ..height = null
      ..columns = columns;

    var grid = new jqGrid(this._resourcesLoaderService, "#worksGrid",
        JsObjectConverter.convert(options));
    await grid.Init();
  }

  Future BudgetGridInit() async {
    var columns = new List<Column>();


    columns.add(new Column()
      ..dataField = 'BudgetName'
      ..text = 'Наименование статьи/подстатьи бюджета');


    var hierarchy = new Hierarchy()
      ..root = 'children';

    var source = new SourceOptions()
      ..url = '//cm-ylng-msk-01/cmas-backend/api/contract/1/works'
      ..id = 'recid'
      ..hierarchy = hierarchy
      ..dataType = 'json';

    var options = new GridOptions()
      ..checkboxes = false
      ..source = source
      ..height = null
      ..columns = columns;

    var grid = new jqGrid(this._resourcesLoaderService, "#bidgetGrid",
        JsObjectConverter.convert(options));
    await grid.Init();
  }
}
