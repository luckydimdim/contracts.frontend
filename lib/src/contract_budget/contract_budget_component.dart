import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html';

import 'package:resources_loader/resources_loader.dart';

import 'package:grid/grid.dart';

@Component(selector: 'contract-budget')
@View(
    templateUrl: 'contract_budget_component.html',
    directives: const [RouterLink])
class ContractBudgetComponent implements OnInit, OnDestroy {
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

  Grid _grid;
  bool budgetExist = true;

  ContractBudgetComponent(this._router, this._resourcesLoaderService) {}

  @override
  void ngOnInit() {
    //checkBudgetExisting();
    showGrid();
  }

  void checkBudgetExisting() {
    var url = _domain + "/api/contractBudget/1";

    var request = HttpRequest.getString(url).then((_) {
      budgetExist = true;
      showGrid();
    }).catchError((Error error) {
      budgetExist = false;
    });
  }

  void createBudget() {
    HttpRequest request = new HttpRequest();

    request.onReadyStateChange.listen((_) {
      if (request.readyState == HttpRequest.DONE &&
          (request.status == 200 || request.status == 0)) {
        checkBudgetExisting();
      }
    });

    var url = _domain + "/api/contractBudget/1/create";
    request.open("POST", url, async: false);

    request.send(); // perform the async POST
  }

  void showGrid() {
    var columns = new List<Column>();
    columns.add(new Column(
        field: 'Code', caption: 'Код этапа', size: '100px', frozen: true));
    columns.add(new Column(
        field: 'Name',
        caption: 'Наименование этапа/работы',
        size: '200px',
        frozen: true));

    var monthColumnWidth = '100px';

    columns.add(new Column(
        field: '01_2017', caption: 'Январь', size: monthColumnWidth));
    columns.add(new Column(
        field: '01_2017', caption: 'Февраль', size: monthColumnWidth));
    columns.add(
        new Column(field: '03_2017', caption: 'Март', size: monthColumnWidth));
    columns.add(new Column(
        field: '04_2017', caption: 'Апрель', size: monthColumnWidth));
    columns.add(
        new Column(field: '05_2017', caption: 'Май', size: monthColumnWidth));
    columns.add(
        new Column(field: '06_2017', caption: 'Июнь', size: monthColumnWidth));
    columns.add(
        new Column(field: '07_2017', caption: 'Июль', size: monthColumnWidth));
    columns.add(new Column(
        field: '08_2017', caption: 'Август', size: monthColumnWidth));
    columns.add(new Column(
        field: '09_2017', caption: 'Сентябрь', size: monthColumnWidth));
    columns.add(new Column(
        field: '10_2017', caption: 'Октябрь', size: monthColumnWidth));
    columns.add(new Column(
        field: '11_2017', caption: 'Ноябрь', size: monthColumnWidth));
    columns.add(new Column(
        field: '12_2017', caption: 'Декабрь', size: monthColumnWidth));

    columns.add(new Column(
        field: '01_2018', caption: 'Январь', size: monthColumnWidth));
    columns.add(new Column(
        field: '01_2018', caption: 'Февраль', size: monthColumnWidth));
    columns.add(
        new Column(field: '03_2018', caption: 'Март', size: monthColumnWidth));
    columns.add(new Column(
        field: '04_2018', caption: 'Апрель', size: monthColumnWidth));
    columns.add(
        new Column(field: '05_2018', caption: 'Май', size: monthColumnWidth));
    columns.add(
        new Column(field: '06_2018', caption: 'Июнь', size: monthColumnWidth));
    columns.add(
        new Column(field: '07_2018', caption: 'Июль', size: monthColumnWidth));
    columns.add(new Column(
        field: '08_2018', caption: 'Август', size: monthColumnWidth));
    columns.add(new Column(
        field: '09_2018', caption: 'Сентябрь', size: monthColumnWidth));
    columns.add(new Column(
        field: '10_2018', caption: 'Октябрь', size: monthColumnWidth));
    columns.add(new Column(
        field: '11_2018', caption: 'Ноябрь', size: monthColumnWidth));
    columns.add(new Column(
        field: '12_2018', caption: 'Декабрь', size: monthColumnWidth));

    var groups = new List<ColumnGroup>();

    groups.add(new ColumnGroup(caption: '', span: 1));
    groups.add(new ColumnGroup(caption: '', span: 1));
    groups.add(new ColumnGroup(caption: '2017', span: 12));
    groups.add(new ColumnGroup(caption: '2018', span: 12));

    var options = new GridOptions()
      ..name = 'grid'
      ..columns = columns
      ..columnGroups = groups
      ..url = _domain + '/api/contractBudget/1/months'
      ..method = 'GET';

    if (_grid != null) {
      _grid.Destroy();
    }

    _grid = new Grid(this._resourcesLoaderService, "#grid", options);
  }

  @override
  void ngOnDestroy() {
    if (_grid != null) {
      _grid.Destroy();
      _grid = null;
    }
  }
}
