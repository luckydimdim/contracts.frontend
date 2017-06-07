import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:angular_utils/cm_positive_number.dart';

import 'amount.dart';

@Component(selector: 'amounts', templateUrl: 'amounts_component.html', directives: const [CmPositiveNumberDirective])
class AmountsComponent implements OnInit {

  @Input()
  List<Amount> amounts = null;

  @Input()
  // все возможные валюты для выбора
  List<String> availableCurrencies = null;

  @Input()
  bool readOnly = false;

  @override
  ngOnInit() {
  }


  bool showPlus(int index, Amount amount) {
    return (index == (amounts.length - 1) && amounts.length > 1 && index < availableCurrencies.length - 1 ) || amounts.length == 1;
  }

  bool showMinus() {
    return amounts.length > 1;
  }

  // список доступных валют для указанной стоимости
  List<String> getCurrencies(int index) {
    List<String> result = new  List<String>();

    if (amounts == null || availableCurrencies == null)
      return result;

    // валюты сумм
    List<String> amountsCurrencies = amounts.map((a) => a.currencySysName).toList();

    result.add(amounts[index].currencySysName);

    result.addAll(availableCurrencies.where((c) => !amountsCurrencies.contains(c)).toList());

    return result;
  }

  // удалить стоимость
  removeAmount(int index) {

    if (amounts == null)
      return;

    if (amounts.length <= 1) return;

    amounts.removeAt(index);
  }

  // добавить стоимость
  addAmount() {

    if (amounts == null || availableCurrencies == null)
      return;

    if (amounts.length >= availableCurrencies.length) return;

    // валюты сумм
    List<String> amountsCurrencies = amounts.map((a) => a.currencySysName).toList();
    List<String> result = availableCurrencies.where((c) => !amountsCurrencies.contains(c)).toList();

    var amount = new Amount()..currencySysName = result.first;

    amounts.insert(amounts.length, amount);
  }

  String getName(Amount amount) {
    return 'amount_${amount.currencySysName}';
  }

  // поменяли валюту
  onChange(int index, String currencySysName) {
    amounts[index] = new Amount()..currencySysName = currencySysName..value =  amounts[index].value;
  }


}
