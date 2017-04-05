import 'dart:html';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:angular_utils/directives.dart';
import 'package:contracts/contracts_service.dart';

@Component(selector: 'contract-layout')
@View(
    templateUrl: 'contract_layout_component.html',
    directives: const [CmRouterLink])
class ContractLayoutComponent implements OnInit, OnDestroy, AfterViewInit {
  final Router _router;
  final RouteParams _routeParams;
  final ContractsService service;

  ContractLayoutComponent(this._router, this._routeParams, this.service);

  @override
  void ngOnInit() {
    createHistoryTab();
  }

  @override
  ngAfterViewInit() {
    sticky();
  }

  /**
   * Фиксация боковой панели
   */
  void sticky() {
    var pane = querySelector('[sticky]');
    if (pane == null) return;

    var width = pane.getComputedStyle().width;

    // При ресайзе окна ширина панели
    // подстраивается под ширину родительского элемента
    window.onResize.listen((Event e) {
      var stickyElement = querySelector('[sticky]');

      if (stickyElement == null) return;

      width = stickyElement.parent.clientWidth;

      var paddingLeft = stickyElement.parent
          .getComputedStyle()
          .paddingLeft
          .replaceAll('px', '');
      var paddingRight = stickyElement.parent
          .getComputedStyle()
          .paddingRight
          .replaceAll('px', '');

      var pl = int.parse(paddingLeft);
      var pr = int.parse(paddingRight);

      width = width - pl - pr;

      stickyElement.style.width = width.toString() + 'px';
    });

    bool topWasSet = false;

    // При прокрутке окна устанавливается position: fixed
    window.onScroll.listen((Event e) {
      if (window.pageXOffset > 0) return;

      // Флаг включенности "режима прилипания"
      bool enabled = false;

      // Высота шапки
      const headerHeight = 55;

      // Отступ родительского элемента
      const navTopPadding = 15;

      // Контейнер, содержимое которого прилипает
      var sticky = querySelector('[sticky]') as HtmlElement;
      if (sticky == null) return;

      // Верхняя отметка, до которой не нужно начинать прилипание
      var stickyTop = querySelector('[sticky-top]') as HtmlElement;
      if (stickyTop != null) {
        enabled = stickyTop.getBoundingClientRect().top - headerHeight <= 0;
      } else {
        enabled = window.pageYOffset > 0;
      }

      if (enabled) {
        if (!topWasSet) {
          // FIXME: при скроле колесом криво считается отступ сверху
          sticky.style.top =
              '${stickyTop.getBoundingClientRect().top + navTopPadding}px';
          topWasSet = true;
        }

        sticky.style.position = 'fixed';
        sticky.style.width = width.toString();
      } else {
        if (topWasSet) {
          sticky.style.top = '0';
          topWasSet = false;
        }

        sticky.style.position = 'relative';
      }
    });
  }

  void showHistory() {

  }

  void createHistoryTab() {
  }

  void destroyHistory() {
  }

  @override
  void ngOnDestroy() {
    destroyHistory();
  }
}
