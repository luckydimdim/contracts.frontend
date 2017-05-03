import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'package:auth/src/role.dart';
import 'package:config/config_service.dart';
import 'package:logger/logger_service.dart';
import 'package:angular_utils/cm_format_money_pipe.dart';
import 'package:resources_loader/resources_loader.dart';
import 'package:auth/auth_service.dart';
import 'contract_general_model.dart';
import '../../contracts_service/contracts_service.dart';

@Component(
    templateUrl: 'contract_general_read_component.html',
    selector: 'contract-general-read',
    pipes: const [CmFormatMoneyPipe])
class ContractGeneralReadComponent implements OnInit {
  final ContractsService service;
  final ConfigService _config;
  final LoggerService _logger;
  final ResourcesLoaderService _resourcesLoader;
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

  ContractGeneralReadComponent(this._config, this._logger,
      this._resourcesLoader, this.service, this._router, this._authorizationService);

  @override
  ngOnInit() async {

    if (_authorizationService.isInRole(Role.Customer))
      readOnly = false;

    breadcrumbInit();
  }

  toggleWriteMode() {
    service.writeEnabled = !service.writeEnabled;
  }

  Future deleteContract() async {
    await service.general.deleteContract(model.id);

    _router.parent.parent.navigate(['ContractList']);

    return null;
  }

  void breadcrumbInit() {}
}
