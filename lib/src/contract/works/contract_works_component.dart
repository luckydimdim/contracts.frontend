import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:call_off_order/src/call_off_order.dart';
import '../general/contract_general_model.dart';
import 'package:resources_loader/resources_loader.dart';
import 'package:call_off_order/call_off_service.dart';
import 'package:call_off_order/call_off_order_component.dart';
import 'package:grid/grid.dart';
import '../../contracts_service/contracts_service.dart';

@Component(
    selector: 'contract-works',
    templateUrl: 'contract_works_component.html',
    providers: const [
      CallOffService
    ],
    directives: const [
      CallOffOrderComponent,
      GridComponent,
      GridTemplateDirective,
      ColumnComponent
    ])
class ContractWorksComponent implements OnInit, OnDestroy {
  static const DisplayName = const {'displayName': 'Работы'};

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;
  final CallOffService _callOffService;
  final ContractsService _contractsService;

  String contractId;
  String callOffTemplateSysName;
  ContractGeneralModel _contractModel;

  /**
   * Первичные документы отсутствуют
   */
  bool isEmpty = false;

  @ViewChild(GridComponent)
  GridComponent grid;

  var worksDataSource = new DataSource();

  ContractWorksComponent(this._router, this._resourcesLoaderService,
      this._callOffService, this._contractsService);

  @override
  Future ngOnInit() async {
    Instruction ci = _router.parent.parent.currentInstruction;
    contractId = ci.component.params['id'];

    await loadCallOffOrders();

    _contractModel = await _contractsService.general.getContract(contractId);

    // TODO: Переименовать
    callOffTemplateSysName = _contractModel.templateSysName;

    return null;
  }

  @override
  void ngOnDestroy() {}

  Future loadCallOffOrders() async {
    List<CallOffOrder> orders =
        await _callOffService.getCallOffOrders(contractId);

    var result = new List<dynamic>();

    for (CallOffOrder order in orders) {
      result.add(order.toMap());
    }

    worksDataSource = new DataSource(data: result)..primaryField = 'id';

    isEmpty = orders.isEmpty;

    return null;
  }

  Future createWork() async {
    String id = await _callOffService.createCallOffOrder(
        contractId, callOffTemplateSysName);

    // TODO: совместить 2 запроса
    var createdCallOff = await _callOffService.getCallOffOrder(id);

    var rowData = createdCallOff.toMap();

    worksDataSource.data.insert(0, rowData);

    if (isEmpty) {
      isEmpty = false;
    } else {
      grid.toggleRow(rowData);
    }

    return null;
  }

  Future deleteWork(String id) async {
    await _callOffService.deleteCallOfOrder(id);

    worksDataSource.data.removeWhere((item) => item['id'] == id);

    isEmpty = worksDataSource.data.isEmpty;

    return null;
  }
}
