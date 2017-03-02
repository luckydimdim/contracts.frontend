import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(selector: 'contract-list')
@View(
  templateUrl: 'contract_list_component.html',
  directives: const [RouterLink])
class ContractListComponent implements OnInit {
  final Router _router;
  static const DisplayName = const {'displayName': 'Список договоров'};

  ContractListComponent(this._router) {}

  void breadcrumbInit() {}

  @override
  void ngOnInit() {
    breadcrumbInit();

    var table = querySelector('[table-click]') as TableElement;
    table.rows.forEach((TableRowElement row) {
      row.onClick.listen((MouseEvent e) {
        var currentRow = e.currentTarget as TableRowElement;
        String link = currentRow.getAttribute('data-href');

        _router.parent.navigateByUrl(link);
      });
    });
  }
}