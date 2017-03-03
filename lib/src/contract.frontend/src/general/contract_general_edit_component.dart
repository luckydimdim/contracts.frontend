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
import 'contract_general_edit_view_model.dart';
import '../contract_layout/contract_layout_component.dart';

@Component(selector: 'contract-general-edit',
  providers: const [BrowserClient, ResourcesLoaderService])
@View(
  templateUrl: 'contract_general_edit_component.html',
  directives: const [ContractLayoutComponent])
class ContractGeneralEditComponent implements OnInit, AfterViewInit {
  static const DisplayName = const {'displayName': 'Редактирование договора'};
  static const String route_name = 'ContractGeneralEdit';
  static const String route_path = 'general-edit';
  static const Route route = const Route(
    path: ContractGeneralEditComponent.route_path,
    component: ContractGeneralEditComponent,
    name: ContractGeneralEditComponent.route_name);

  ContractGeneralEditViewModel model = new ContractGeneralEditViewModel();
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

  ContractGeneralEditComponent(this._http, this._config, this._logger, this._resourcesLoader) {}

  onSubmit() async {
    _logger.trace('Editing contract ${model.toJsonString()}');

    print(model.toJsonString());

    try {
      await _http.put(_config.helper.contractsUrl,
        headers: {'Content-Type': 'application/json'},
        body: model.toJsonString());
      _logger.trace('Contract ${model.name} edited');
    } catch (e) {
      _logger.error('Failed to edit contract: $e');

      throw new Exception('Failed to edit contract. Cause: $e');
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

    model.name = '1';
    model.number = '2';
    model.startDate = '3';
    model.finishDate = '4';
    model.contractorName = '5';
    model.currency = '6';
    model.amount = '7';
    model.vatIncluded = true;
    model.constructionObjectName = '9';
    model.constructionObjectTitleName = '10';
    model.constructionObjectTitleCode = '11';
    model.description = '12';
  }
}