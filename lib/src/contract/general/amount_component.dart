import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:angular_utils/cm_positive_number.dart';

import 'amount.dart';

@Component(selector: 'amount', templateUrl: 'amount_component.html', directives: [CmPositiveNumberDirective])
class AmountComponent implements OnInit {
  @Input()
  Amount model = new Amount();

  @Input()
  bool readOnly = false;

  @Input()
  bool showPlus = true;

  @Input()
  bool showMinus = true;

  @Input()
  List<String> currencies = new List<String>();

  StreamController<AmountComponent> onAddAmount =
      new StreamController<AmountComponent>.broadcast();
  StreamController<AmountComponent> onRemoveAmount =
      new StreamController<AmountComponent>.broadcast();
  StreamController<AmountComponent> onUpdateAmount =
      new StreamController<AmountComponent>.broadcast();

  @Output()
  // Событие добавления стоимости во внешний компонент
  Stream get addAmount => onAddAmount.stream;

  @Output()
  // Событие удаления стоимости во внешний компонент
  Stream get removeAmount => onRemoveAmount.stream;

  @Output()
  // Событие обновления стоимости во внешний компонент
  Stream get updateAmount => onUpdateAmount.stream;

  @override
  ngOnInit() {
    currencies.add('RUR');
    currencies.add('USD');
    currencies.add('JPY');
    currencies.add('EUR');
  }

  // Публикует событие добавления стоимости во внешний компонент
  void emitAdd() {
    onAddAmount.add(this);
  }

  // Публикует событие удаления стоимости во внешний компонент
  void emitRemove() {
    onRemoveAmount.add(this);
  }

  // Публикует событие изменения стоимости во внешний компонент
  void emitUpdate() {
    onUpdateAmount.add(this);
  }
}
