import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'dart:html';
import 'package:resources_loader/resources_loader.dart';
import 'package:grid/JsObjectConverter.dart';
import 'package:grid/jq_grid.dart';

@Component(
    selector: 'contract-works', templateUrl: 'contract_works_component.html')
class ContractWorksComponent implements OnInit, OnDestroy {
  static const String route_name = 'ContractWorks';
  static const String route_path = 'works';
  static const Route route = const Route(
      path: ContractWorksComponent.route_path,
      component: ContractWorksComponent,
      name: ContractWorksComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;
  jqGrid _worksGrid;

  ContractWorksComponent(this._router, this._resourcesLoaderService) {}

  // import 'dart:html';
  void breadcrumbInit(){
    var  breadcrumbContent = querySelector('#breadcrumbContent') as OListElement;

    if (breadcrumbContent == null)
      return;

    breadcrumbContent.innerHtml = '''
            <li class="breadcrumb-item"><a href="#/master/dashboard">Главная</a></li>
            <li class="breadcrumb-item"><a href="#/master/contractList">Список договоров</a></li>
            <li class="breadcrumb-item"><a href="#/master/contract">Договор 644/15-ЯСПГ</a></li>
            <li class="breadcrumb-item active">Работы</li>
    ''';
  }

  @override
  void ngOnInit() {
    breadcrumbInit();
    WorksGridInit();
  }

  @override
  void ngOnDestroy() {}

  Future WorksGridInit() async {
    var columns = new List<Column>();

    columns.add(new Column()
      ..dataField = 'Name'
      ..text = 'Наименование этапа/работы'
      ..pinned = true);

    columns.add(new Column()
      ..dataField = 'BeginDate'
      ..cellsFormat = 'd'
      ..text = 'Начало');
    columns.add(new Column()
      ..dataField = 'EndDate'
      ..text = 'Окончание');
    columns.add(new Column()
      ..dataField = 'Unit'
      ..text = 'Ед. изм.');
    columns.add(new Column()
      ..dataField = 'UnitCost'
      ..text = 'Cтоимость ед измерения');
    columns.add(new Column()
      ..dataField = 'Amount'
      ..text = 'Объем');
    columns.add(new Column()
      ..dataField = 'Cost'
      ..text = 'Стоимость');
    columns.add(new Column()
      ..dataField = 'Currency'
      ..text = 'Валюта');
    /*columns.add(new Column()
      ..dataField = 'ContractorName'
      ..text = 'Исполнитель');*/

    var hierarchy = new Hierarchy()..root = 'children';

    var source = new SourceOptions()
      ..url = 'packages/contract/src/works/works.json'
      ..id = 'recid'
      ..hierarchy = hierarchy
      ..dataType = 'json';

    var options = new GridOptions()
      ..checkboxes = false
      ..source = source
      ..height = null
      ..columns = columns;

    _worksGrid = new jqGrid(this._resourcesLoaderService, "#worksGrid",
        JsObjectConverter.convert(options));
    await _worksGrid.Init();
  }
}
