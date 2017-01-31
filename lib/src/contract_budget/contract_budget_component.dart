import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:js/js_util.dart';
import 'package:js/js.dart';

import 'package:resources_loader/resources_loader.dart';

import 'package:grid/JsObjectConverter.dart';
import 'package:grid/jq_grid.dart';

@Component(selector: 'contract-budget')
@View(
    templateUrl: 'contract_budget_component.html',
    directives: const [RouterLink])
class ContractBudgetComponent
    implements OnInit, OnDestroy {
  static const String route_name = "ContractBudget";
  static const String route_path = "contract-budget";
  static const Route route = const Route(
      path: ContractBudgetComponent.route_path,
      component: ContractBudgetComponent,
      name: ContractBudgetComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  /**
   * //cm-ylng-msk-01/cmas-backend
   * //localhost:5000
   */
  static const String _domain = "//cm-ylng-msk-01/cmas-backend";

  //static const String _domain = "http://localhost:5000";

  bool budgetExist = true;

  ContractBudgetComponent(this._router, this._resourcesLoaderService) {}

  @override
  void ngOnInit() {
    showGrid(
        "#grid1", 'packages/contract/src/contract_budget/months_budget1.json');
    showGrid(
        "#grid2", 'packages/contract/src/contract_budget/months_budget2.json');
    showGrid(
        "#grid3", 'packages/contract/src/contract_budget/months_budget3.json');


    $('a[data-toggle="tab"]').on('shown.bs.tab', allowInterop(render));
  }


  void render(dynamic e) {
    var target = getProperty(e, 'target');
    var hash = getProperty(target, 'hash');

    var selector = hash.toString().replaceRange(0, 5, '');

    $("#$selector").jqxTreeGrid('render');
  }

  Future showGrid(String selector, url) async {
    var columns = new List<Column>();

    columns.add(new Column()
      ..dataField = 'Name'
      ..text = 'Наименование этапа/работы'
      ..width = '400px'
      ..pinned = true);

    var monthColumnWidth = '100px';

    columns.add(new Column()
      ..dataField = '01_2017'
      ..text = 'Январь'
      ..columnGroup = '2017'
      ..width = monthColumnWidth);

    columns.add(new Column()
      ..dataField = '02_2017'
      ..text = 'Февраль'
      ..columnGroup = '2017'
      ..width = monthColumnWidth);

    columns.add(new Column()
      ..dataField = '03_2017'
      ..text = 'Март'
      ..columnGroup = '2017'
      ..width = monthColumnWidth);

    columns.add(new Column()
      ..dataField = '04_2017'
      ..text = 'Апрель'
      ..columnGroup = '2017'
      ..width = monthColumnWidth);

    columns.add(new Column()
      ..dataField = '05_2017'
      ..text = 'Май'
      ..columnGroup = '2017'
      ..width = monthColumnWidth);

    columns.add(new Column()
      ..dataField = '06_2017'
      ..text = 'Июнь'
      ..columnGroup = '2017'
      ..width = monthColumnWidth);

    columns.add(new Column()
      ..dataField = '07_2017'
      ..text = 'Июль'
      ..columnGroup = '2017'
      ..width = monthColumnWidth);

    columns.add(new Column()
      ..dataField = '08_2017'
      ..text = 'Август'
      ..columnGroup = '2017'
      ..width = monthColumnWidth);

    columns.add(new Column()
      ..dataField = '09_2017'
      ..text = 'Сентябрь'
      ..columnGroup = '2017'
      ..width = monthColumnWidth);

    columns.add(new Column()
      ..dataField = '10_2017'
      ..text = 'Октябрь'
      ..columnGroup = '2017'
      ..width = monthColumnWidth);

    columns.add(new Column()
      ..dataField = '11_2017'
      ..text = 'Ноябрь'
      ..columnGroup = '2017'
      ..width = monthColumnWidth);

    columns.add(new Column()
      ..dataField = '12_2017'
      ..text = 'Декабрь'
      ..columnGroup = '2017'
      ..width = monthColumnWidth);

    var groups = new List<ColumnGroup>();

    groups.add(new ColumnGroup()
      ..name = '2017'
      ..text = '2017'
      ..align = 'center');
    groups.add(new ColumnGroup()
      ..name = '2017'
      ..text = '2018'
      ..align = 'center');

    var hierarchy = new Hierarchy()
      ..root = 'children';

    var source = new SourceOptions()
    //..url = _domain + '/api/contractBudget/1/months'
      ..url = url
      ..id = 'recid'
      ..hierarchy = hierarchy
      ..dataType = 'json';

    var options = new GridOptions()
      ..checkboxes = false
      ..source = source
      ..height = '65vh'
      ..columnGroups = groups
      ..columns = columns;

    var _worksGrid = new jqGrid(this._resourcesLoaderService, selector,
        JsObjectConverter.convert(options));

    await _worksGrid.Init();
  }

  @override
  void ngOnDestroy() {}
}
