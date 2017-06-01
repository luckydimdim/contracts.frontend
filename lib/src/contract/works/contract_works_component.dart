import 'dart:async';
import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:call_off_order/src/call_off_order.dart';
import '../general/contract_general_model.dart';
import 'package:call_off_order/call_off_service.dart';
import 'package:call_off_order/call_off_order_component.dart';
import 'package:auth/auth_service.dart';
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
  final CallOffService _callOffService;
  final ContractsService _contractsService;
  final AuthorizationService _authorizationService;

  String contractId;
  String callOffTemplateSysName;
  ContractGeneralModel _contractModel;

  /**
   * Первичные документы отсутствуют
   */
  bool isEmpty = false;

  bool readOnly = true;

  @ViewChild(GridComponent)
  GridComponent grid;

  var worksDataSource = new DataSource();

  ContractWorksComponent(this._router, this._callOffService,
      this._contractsService, this._authorizationService);

  @override
  Future ngOnInit() async {
    Instruction ci = _router.parent.parent.currentInstruction;
    contractId = ci.component.params['id'];

    await loadCallOffOrders();

    _contractModel = await _contractsService.general.getContract(contractId);

    // TODO: Переименовать
    callOffTemplateSysName = _contractModel.templateSysName;

    if (_authorizationService.isInRole(Role.Customer)) readOnly = false;

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

  // добавить наряд заказ
  Future createWork() async {
    String id = await _callOffService.createCallOffOrder(contractId);

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

  // удалить наряд заказ
  deleteWork(String id) async {
    if (!window.confirm('Удалить наряд-заказ?')) return;

    await _callOffService.deleteCallOfOrder(id);

    worksDataSource.data.removeWhere((item) => item['id'] == id);

    isEmpty = worksDataSource.data.isEmpty;

    return;
  }

  /**
   * Нажатие на кнопку "Завершить"
   */
  void finish(dynamic row) {
    grid.toggleRow(row);
  }
}
