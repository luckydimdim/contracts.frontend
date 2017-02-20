import 'dart:html';
import 'package:angular2/core.dart';

import 'package:angular_utils/directives.dart';

@Component(selector: 'contract-layout')
@View(
  templateUrl: 'contract_layout_component.html',
  directives: const [CmRouterLink])
class ContractLayoutComponent implements AfterViewInit {
  @override
  ngAfterViewInit() {
    sticky();
  }

  /**
   * Фиксация боковой панели
   */
  void sticky() {
    var width = querySelector('[sticky]').getComputedStyle().width;

    // При ресайзе окна ширина панели
    // подстраивается под ширину родительского элемента
    window.onResize.listen((Event e) {
      width = querySelector('[sticky]').parent.clientWidth;

      var paddingLeft = querySelector('[sticky]').parent.getComputedStyle().paddingLeft.replaceAll('px', '');
      var paddingRight = querySelector('[sticky]').parent.getComputedStyle().paddingRight.replaceAll('px', '');

      var pl = int.parse(paddingLeft);
      var pr = int.parse(paddingRight);

      width = width - pl - pr;

      querySelector('[sticky]').style.width = width.toString() + 'px';
    });

    // При прокрутке окна устанавливается position: fixed
    window.onScroll.listen((Event e) {
      if (window.pageXOffset > 0)
        return;

      var div = querySelector('[sticky]') as HtmlElement;
      if (window.pageYOffset > 0) {
        div.style.position = 'fixed';
        div.style.width = width;
      } else {
        div.style.position = 'relative';
      }
    });
  }
}