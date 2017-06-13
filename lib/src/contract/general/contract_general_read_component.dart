import 'dart:html';
import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'package:auth/src/role.dart';
import 'package:angular_utils/pipes.dart';
import 'package:angular_utils/directives.dart';
import 'package:auth/auth_service.dart';
import 'contract_general_model.dart';
import '../../contracts_service/contracts_service.dart';

@Component(
    templateUrl: 'contract_general_read_component.html',
    selector: 'contract-general-read',
    pipes: const [CmFormatMoneyPipe],
    directives: const [CmLoadingBtnDirective])
class ContractGeneralReadComponent implements OnInit {
  final ContractsService service;
  final Router _router;
  final AuthorizationService _authorizationService;

  bool readOnly = true;

  @Input()
  ContractGeneralModel model = new ContractGeneralModel();

  Map<String, bool> controlStateClasses(NgControl control) => {
        'ng-dirty': control.dirty ?? false,
        'ng-pristine': control.pristine ?? false,
        'ng-touched': control.touched ?? false,
        'ng-untouched': control.untouched ?? false,
        'ng-valid': control.valid ?? false,
        'ng-invalid': control.valid == false
      };

  ContractGeneralReadComponent(
      this.service, this._router, this._authorizationService);

  @override
  ngOnInit() async {
    if (_authorizationService.isInRole(Role.Customer)) readOnly = false;

    breadcrumbInit();
  }

  toggleWriteMode() {
    service.writeEnabled = !service.writeEnabled;
  }

  Future deleteContract() async {
    if (!window.confirm('Удалить контракт?')) return;

    await service.general.deleteContract(model.id);

    await _router.parent.parent.navigate(['ContractList']);
  }

  void breadcrumbInit() {}
}
