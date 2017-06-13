import 'dart:async';
import 'dart:html';

import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:daterangepicker/daterangepicker.dart';
import 'package:daterangepicker/daterangepicker_directive.dart';
import 'contract_general_model.dart';
import '../../contracts_service/contracts_service.dart';
import 'amounts_component.dart';
import 'amount.dart';
import 'package:angular_utils/cm_loading_btn_directive.dart';

@Component(
    selector: 'contract-general-write',
    templateUrl: 'contract_general_write_component.html',
    directives: const [
      DateRangePickerDirective,
      AmountsComponent,
      CmLoadingBtnDirective
    ])
class ContractGeneralWriteComponent {
  final ContractsService service;
  final Router _router;

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

  ContractGeneralWriteComponent(this.service, this._router) {
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

    dateRangePickerOptions = new DateRangePickerOptions()..locale = locale;
  }

  // нажали кнопку назад
  onBack() async {
    if (service.creatingMode) {
      _router.navigate(['../../ContractList']);
    } else {
      service.writeEnabled = !service.writeEnabled;

      // перезагружаем, т.к. могли не нажать кнопку сохранить
      service.model = await service.general.getContract(service.contractId);
    }
  }

  /**
   * Удаление договора
   */
  Future deleteContract() async {
    if (!window.confirm('Удалить контракт?')) return null;

    await service.general.deleteContract(model.id);

    _router.parent.parent.navigate(['ContractList']);

    return null;
  }

  /**
   * Обработка события выбора даты договора
   */
  Future contractDateSelected(Map<String, DateTime> dates) async {
    model.startDate = dates['start'];
    model.finishDate = dates['end'];
  }

  String getDates() {
    String result = '';

    if (model.startDate != null && model.finishDate != null)
      result = '${model.startDateStr} - ${model.finishDateStr}';

    if (model.startDate == null && model.finishDate == null) result = '';

    if (model.startDate == null) result = model.finishDateStr;

    if (model.finishDate == null) result = model.startDateStr;

    return result;
  }

  // сохранить/создать
  Future save() async {
    if (service.creatingMode) {
      String id = await service.general.createContract(model);

      _router.navigate([
        '../../Contract',
        {'id': id}
      ]);
    } else {
      await service.general.updateContract(model);

      service.writeEnabled = false;
    }
  }

  List<String> availableCurrencies() {
    var result = new List<String>();

    result.add('RUR');
    result.add('USD');
    result.add('JPY');
    result.add('EUR');

    return result;
  }
}
