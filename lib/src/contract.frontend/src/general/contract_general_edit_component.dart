import 'dart:async';

import 'dart:html';
import 'package:angular2/common.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:http/browser_client.dart';

import 'package:config/config_service.dart';
import 'package:json_object/json_object.dart';
import 'package:logger/logger_service.dart';
import 'package:resources_loader/resources_loader.dart';
import 'package:daterangepicker/daterangepicker.dart';
import 'contract_general_edit_view_model.dart';
import '../contract_layout/contract_layout_component.dart';
import '../contracts_service/contracts_service.dart';

@Component(selector: 'contract-general-edit',
  providers: const [BrowserClient, ResourcesLoaderService, ContractsService])
@View(
  templateUrl: 'contract_general_edit_component.html',
  directives: const [ContractLayoutComponent])
class ContractGeneralEditComponent implements OnInit, AfterViewInit {
  static const DisplayName = const {'displayName': 'Редактирование договора'};
  static const String route_name = 'ContractGeneralEdit';
  static const String route_path = '/:id/general-edit';
  static const Route route = const Route(
    path: ContractGeneralEditComponent.route_path,
    component: ContractGeneralEditComponent,
    name: ContractGeneralEditComponent.route_name);

  ContractGeneralEditViewModel model = new ContractGeneralEditViewModel();
  ContractsService _db;
  ConfigService _config;
  LoggerService _logger;
  ResourcesLoaderService _resourcesLoader;
  RouteParams _routeParams;

  Map<String, bool> controlStateClasses(NgControl control) => {
    'ng-dirty': control.dirty ?? false,
    'ng-pristine': control.pristine ?? false,
    'ng-touched': control.touched ?? false,
    'ng-untouched': control.untouched ?? false,
    'ng-valid': control.valid ?? false,
    'ng-invalid': control.valid == false
  };

  ContractGeneralEditComponent(this._db, this._config, this._logger, this._resourcesLoader, this._routeParams) {}

  @override
  Future ngOnInit() async {
    breadcrumbInit();

    String contractId = _routeParams.get('id');
    JsonObject contract = await _db.getContract(contractId);

    model.id = contract.id;
    model.name = contract.id;
    model.number = contract.id;
    model.startDate = contract.id;
    model.finishDate = contract.id;
    model.contractorName = contract.id;
    model.currency = contract.id;
    model.amount = contract.id;
    model.vatIncluded = contract.id;
    model.constructionObjectName = contract.id;
    model.constructionObjectTitleName = contract.id;
    model.constructionObjectTitleCode = contract.id;
    model.description = contract.id;

    return null;
  }

  Future onSubmit() async {
    await _db.editContract(model);
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

    /*model.name = '1';
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
    model.description = '12';*/
  }
}