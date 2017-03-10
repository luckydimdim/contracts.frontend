import 'dart:async';

import 'dart:html';
import 'package:alert/alert_service.dart';
import 'package:angular2/common.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:intl/intl.dart';

import 'package:http/browser_client.dart';

import 'package:config/config_service.dart';
import 'package:logger/logger_service.dart';
import 'package:resources_loader/resources_loader.dart';
import 'package:daterangepicker/daterangepicker.dart';
import 'package:daterangepicker/daterangepicker_directive.dart';
import 'contract_general_model.dart';
import '../../../contracts_service/contracts_service.dart';


@Component(
  selector: 'contract-general-write'
)
@View(
  templateUrl: 'contract_general_write_component.html',
  directives: const [DateRangePickerDirective])
class ContractGeneralWriteComponent implements OnInit {
  final ContractsService service;
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

  DateRangePickerOptions dateRangePickerOptions = new DateRangePickerOptions();

  ContractGeneralWriteComponent(this.service, this._config, this._logger, this._resourcesLoader, this._routeParams, this._router, this._alert) {
    var locale = new DateRangePickerLocale()
      ..format = 'DD.MM.YYYY'
      ..separator = ' - '
      ..applyLabel = 'Применить'
      ..cancelLabel = 'Отменить'
      ..fromLabel = 'С'
      ..toLabel = 'По'
      ..customRangeLabel = 'Custom'
      ..weekLabel = 'W'
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
        'Декабрь'
      ]
      ..firstDay = 1;

    dateRangePickerOptions = new DateRangePickerOptions()
      ..singleDatePicker = true
      //..startDate = '02.03.2017'
      ..locale = locale;
  }

  generalEdit() {
    service.writeEnabled = !service.writeEnabled;
  }

  Future removeContract() async {
    await service.general.deleteContract(model.id);

    _router.parent.parent.navigate(['ContractList']);

    return null;
  }

  @override
  ngOnInit() {
    breadcrumbInit();
  }

  onChange() async {
    await service.general.updateContract(model);
    //_alert.Info('Месседж!');
  }

  void breadcrumbInit() {}

  Future dateSelected(Map<String, DateTime> dates) async {

    var formatter = new DateFormat('dd.MM.yyyy');
    String formatted = formatter.format(dates['start']);

    model.startDate = formatted;

    await onChange();

    return null;
  }
}