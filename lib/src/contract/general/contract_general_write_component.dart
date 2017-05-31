import 'dart:async';
import 'dart:html';

import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:daterangepicker/daterangepicker.dart';
import 'package:daterangepicker/daterangepicker_directive.dart';
import 'contract_general_model.dart';
import '../../contracts_service/contracts_service.dart';
import 'amount_component.dart';
import 'amount.dart';

@Component(
    selector: 'contract-general-write',
    templateUrl: 'contract_general_write_component.html',
    directives: const [DateRangePickerDirective, AmountComponent])
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
  onBack() {
    if (service.creatingMode) {
      _router.navigate(['../../ContractList']);
    } else {
      service.writeEnabled = !service.writeEnabled;
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

  removeAmount(int index) async {
    if (model.amounts.length <= 1) return;

    model.amounts.removeAt(index);
  }

  addAmount(AmountComponent amountComponent) async {
    if (model.amounts.length >= 4) return;

    var amount = new Amount()..currencySysName = 'RUR';

    model.amounts.insert(model.amounts.length, amount);
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
}
