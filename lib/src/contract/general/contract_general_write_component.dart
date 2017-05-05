import 'dart:async';

import 'package:alert/alert_service.dart';
import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:config/config_service.dart';
import 'package:logger/logger_service.dart';
import 'package:resources_loader/resources_loader.dart';
import 'package:daterangepicker/daterangepicker.dart';
import 'package:daterangepicker/daterangepicker_directive.dart';
import 'contract_general_model.dart';
import '../../contracts_service/contracts_service.dart';

@Component(
    selector: 'contract-general-write',
    templateUrl: 'contract_general_write_component.html',
    directives: const [DateRangePickerDirective])
class ContractGeneralWriteComponent {
  final ContractsService service;
  final ConfigService _config;
  final LoggerService _logger;
  final ResourcesLoaderService _resourcesLoader;
  final RouteParams _routeParams;
  final Router _router;
  final AlertService _alert;

  @Input()
  ContractGeneralModel model = null;

  Map<String, bool> controlStateClasses(NgControl control) => {
        'ng-dirty': control.dirty ?? false,
        'ng-pristine': control.pristine ?? false,
        'ng-touched': control.touched ?? false,
        'ng-untouched': control.untouched ?? false,
        'ng-valid': control.valid ?? false,
        'ng-invalid': control.valid == false
      };

  DateRangePickerOptions dateRangePickerOptions = new DateRangePickerOptions();

  ContractGeneralWriteComponent(this.service, this._config, this._logger,
      this._resourcesLoader, this._routeParams, this._router, this._alert) {
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
        'Декабрь'
      ];

    dateRangePickerOptions = new DateRangePickerOptions()
      ..singleDatePicker = true
      ..locale = locale;
  }

  toggleWriteMode() {
    service.writeEnabled = !service.writeEnabled;
  }

  /**
   * Удаление договора
   */
  Future deleteContract() async {
    await service.general.deleteContract(model.id);

    _router.parent.parent.navigate(['ContractList']);

    return null;
  }

  Future onChange(NgForm ngForm) async {
    // FIXME: придумать способ апдейта отдельных полей
    //if (ngForm == null || ngForm.form.status == 'VALID') {
    await service.general.updateContract(model);
    //}

    return null;
  }

  /**
   * Обработка события выбора даты заключения договора
   */
  Future startDateSelected(Map<String, DateTime> dates) async {
    model.startDate = dates['start'];

    await onChange(null);

    return null;
  }

  /**
   * Обработка события выбора даты окончания договора
   */
  Future finishDateSelected(Map<String, DateTime> dates) async {
    model.finishDate = dates['start'];

    await onChange(null);

    return null;
  }
}
