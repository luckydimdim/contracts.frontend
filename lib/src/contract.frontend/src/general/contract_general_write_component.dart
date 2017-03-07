import 'dart:async';

import 'dart:html';
import 'package:alert/alert_service.dart';
import 'package:angular2/common.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:http/browser_client.dart';

import 'package:config/config_service.dart';
import 'package:logger/logger_service.dart';
import 'package:resources_loader/resources_loader.dart';
import 'package:daterangepicker/daterangepicker.dart';
import 'contract_general_model.dart';
import '../../../contracts_service/contracts_service.dart';


@Component(selector: 'contract-general-write')
@View(templateUrl: 'contract_general_write_component.html')
class ContractGeneralWriteComponent implements OnInit, AfterViewInit {
  final ContractsService _service;
  final ConfigService _config;
  final LoggerService _logger;
  final ResourcesLoaderService _resourcesLoader;
  final RouteParams _routeParams;
  final Router _router;
  final AlertService _alert;

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

  ContractGeneralWriteComponent(this._service, this._config, this._logger, this._resourcesLoader, this._routeParams, this._router, this._alert);

  @override
  ngOnInit() {
    breadcrumbInit();
  }

  onChange() async {
    await _service.general.updateContract(model);
    _alert.Info('Месседж!');
  }

  void breadcrumbInit() {}

  @override
  Future ngAfterViewInit() async {
    var locale = new DateRangePickerLocale()
      ..format = 'DD.MM.YYYY'
      ..separator = ' - '
      ..applyLabel = 'Применить'
      ..cancelLabel = 'Отменить'
      ..fromLabel = 'С'
      ..toLabel = 'По'
      ..customRangeLabel = 'Custom'
      ..weekLabel = 'W'
      ..firstDay = 1
      ..daysOfWeek = ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб']
      ..monthNames = [
        'Январь',
        'Февраль',
        'Март',
        'Апрель',
        'Май',
        'Июнь',
        'Июль',
        'Август',
        'Сентябрь',
        'Октябрь',
        'Ноябрь',
        'Декабрь'];

    var options = new DateRangePickerOptions()
      ..singleDatePicker = true
      ..autoApply = true
      ..locale = locale;

    new DateRangePicker(_resourcesLoader, '[date-range-picker]', options);

    return null;
  }
}