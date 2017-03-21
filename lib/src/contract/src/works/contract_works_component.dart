import 'dart:async';
import 'dart:convert';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:call_off_order/src/call_off_order.dart';
import 'package:resources_loader/resources_loader.dart';
import 'package:call_off_order/call_off_service.dart';
import 'package:call_off_order/call_off_order_component.dart';
import 'package:grid/datasource.dart';
import 'package:grid/grid_component.dart';
import 'package:grid/column_component.dart';
import 'package:grid/grid_template_directive.dart';


@Component(
    selector: 'contract-works',
    templateUrl: 'contract_works_component.html',
    providers: const[CallOffService],
directives: const [CallOffOrderComponent, GridComponent, GridTemplateDirective, ColumnComponent]
)
class ContractWorksComponent implements OnInit, OnDestroy {
  static const String route_name = 'ContractWorks';
  static const String route_path = 'works';
  static const Route route = const Route(
      path: ContractWorksComponent.route_path,
      component: ContractWorksComponent,
      name: ContractWorksComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;
  final CallOffService _callOffService;

  String contractId;

  @ViewChild(GridComponent)
  GridComponent grid;

  var worksDataSource = new DataSource(new List());

  ContractWorksComponent(this._router, this._resourcesLoaderService,
      this._callOffService) {}

  void breadcrumbInit() {}

  @override
  Future ngOnInit() async {
    breadcrumbInit();

    Instruction ci = _router.parent.parent.currentInstruction;
    contractId = ci.component.params['id'];

    await loadCallOffOrders();

    return null;
  }

  @override
  void ngOnDestroy() {}

  Future loadCallOffOrders() async {
    List<CallOffOrder> orders = await _callOffService.getCallOffOrders(contractId);

    print(orders.length);

    var result = new List<dynamic>();

    for (CallOffOrder order in orders) {
      result.add(order.toMap());
    }

    worksDataSource = new DataSource(result)
      ..primaryField = 'id';

    return null;
  }

  Future createWork() async {

    await loadCallOffOrders();

    String id = await _callOffService.createCallOffOrder();

    var createdCallOff = await _callOffService.getCallOffOrder(id);

    var rowData = createdCallOff.toMap();

    worksDataSource.data.insert(0, rowData);

    grid.toggleRow(rowData);

    return null;
  }

}
