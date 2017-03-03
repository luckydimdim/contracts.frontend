import 'dart:async';

import 'dart:html';
import 'package:angular2/common.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:http/browser_client.dart';

import 'package:config/config_service.dart';
import 'package:logger/logger_service.dart';
import 'package:resources_loader/resources_loader.dart';
import 'package:daterangepicker/daterangepicker.dart';
import 'contract_general_create_view_model.dart';
import '../contract_layout/contract_layout_component.dart';

@Component(selector: 'contract-general-create',
  providers: const [BrowserClient, ResourcesLoaderService])
@View(
  templateUrl: 'contract_general_create_component.html',
  directives: const [ContractLayoutComponent])
class ContractGeneralCreateComponent implements OnInit, AfterViewInit {
  static const DisplayName = const {'displayName': 'Создание договора'};
  static const String route_name = 'ContractGeneralCreate';
  static const String route_path = 'general-create';
  static const Route route = const Route(
    path: ContractGeneralCreateComponent.route_path,
    component: ContractGeneralCreateComponent,
    name: ContractGeneralCreateComponent.route_name,
    useAsDefault: true);

  ContractGeneralCreateViewModel model = new ContractGeneralCreateViewModel();
  BrowserClient _http;
  ConfigService _config;
  LoggerService _logger;
  ResourcesLoaderService _resourcesLoader;

  Map<String, bool> controlStateClasses(NgControl control) => {
    'ng-dirty': control.dirty ?? false,
    'ng-pristine': control.pristine ?? false,
    'ng-touched': control.touched ?? false,
    'ng-untouched': control.untouched ?? false,
    'ng-valid': control.valid ?? false,
    'ng-invalid': control.valid == false
  };

  ContractGeneralCreateComponent(this._http, this._config, this._logger, this._resourcesLoader) {}

  Future onSubmit() async {
    _logger.trace('Creating contract ${model.toJsonString()}');

    print(model.toJsonString());

    try {
      await _http.post(_config.helper.contractsUrl,
        headers: {'Content-Type': 'application/json'},
        body: model.toJsonString());
      _logger.trace('Contract ${model.name} created');

      return null;
    } catch (e) {
      print('Failed to create contract: $e');
      _logger.error('Failed to create contract: $e');

      return new Exception('Failed to create contract. Cause: $e');
    }
  }

  @override
  void ngOnInit() {
    breadcrumbInit();
  }

  void breadcrumbInit() {}

  @override
  ngAfterViewInit() {
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
      ..locale = locale;

    new DateRangePicker(_resourcesLoader, '[date-range-picker]', options);
  }
}