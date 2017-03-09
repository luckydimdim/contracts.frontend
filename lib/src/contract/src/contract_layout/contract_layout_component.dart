import 'dart:html';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:angular_utils/directives.dart';

@Component(
  selector: 'contract-layout')
@View(
    templateUrl: 'contract_layout_component.html',
    directives: const [CmRouterLink])
class ContractLayoutComponent implements OnInit, OnDestroy, AfterViewInit {
  final Router _router;
  final RouteParams _routeParams;

  ContractLayoutComponent(this._router, this._routeParams);

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
    var width = querySelector('[sticky]').getComputedStyle().width;

    // При ресайзе окна ширина панели
    // подстраивается под ширину родительского элемента
    window.onResize.listen((Event e) {
      width = querySelector('[sticky]').parent.clientWidth;

      var paddingLeft = querySelector('[sticky]')
          .parent
          .getComputedStyle()
          .paddingLeft
          .replaceAll('px', '');
      var paddingRight = querySelector('[sticky]')
          .parent
          .getComputedStyle()
          .paddingRight
          .replaceAll('px', '');

      var pl = int.parse(paddingLeft);
      var pr = int.parse(paddingRight);

      width = width - pl - pr;

      querySelector('[sticky]').style.width = width.toString() + 'px';
    });

    // При прокрутке окна устанавливается position: fixed
    window.onScroll.listen((Event e) {
      if (window.pageXOffset > 0) return;

      var div = querySelector('[sticky]') as HtmlElement;
      if (window.pageYOffset > 0) {
        div.style.position = 'fixed';
        div.style.width = width;
      } else {
        div.style.position = 'relative';
      }
    });
  }

  void showHistory() {
    // TODO: Продумать показ/скрытие меню
    document.body.classes.add('mobile-open');
    document.body.classes.add('aside-menu-open');

    // TODO: Сделать более удобным переключение вкладок и показ/скрытие меню
    var oldActiveLink =
        querySelector('.aside-menu .nav-tabs li a.active') as AnchorElement;

    oldActiveLink.classes.remove('active');

    var newActiveLink =
        querySelector('.aside-menu .nav-tabs li a[href="#history"]')
            as AnchorElement;
    newActiveLink.classes.add('active');

    var oldActivePanel =
        querySelector('.aside-menu .tab-content div.active') as DivElement;
    oldActivePanel.classes.remove('active');

    var newActivePanel =
        querySelector('.aside-menu .tab-content div[id="history"]')
            as DivElement;
    newActivePanel.classes.add('active');
  }

  void createHistoryTab() {
    var navTabs = querySelector('.aside-menu .nav-tabs') as UListElement;
    var navTabContent = querySelector('.aside-menu .tab-content') as DivElement;

    if (navTabs == null || navTabContent == null) return;

    var historyTab = new LIElement()
      ..className = 'nav-item'
      ..id = 'historyTab';
    var historyAnchor = new AnchorElement(href: '#history')
      ..className = 'nav-link';
    historyAnchor.setAttribute('data-toggle', 'tab');
    historyAnchor.setAttribute('role', 'tab');

    var historyCursive = new Element.tag('i')..className = 'fa fa-history';

    historyAnchor.append(historyCursive);
    historyTab.append(historyAnchor);
    navTabs.append(historyTab);

    var historyContentDiv = new DivElement()
      ..className = 'tab-pane'
      ..id = 'history';
    historyContentDiv.setAttribute('role', 'tabpanel');
    historyContentDiv.setAttribute('aria-expanded', 'false');

    //historyContentDiv.classes.add('p-1');

    historyContentDiv.innerHtml = '''
<div class="callout m-0 py-h text-muted text-xs-center bg-faded text-uppercase">
	<small><b>Версии документа</b>
	</small>
</div>
<hr class="transparent mx-1 my-0">
<div class="callout callout-warning m-0 py-1">
	<div class="pull-xs-right">
		<small class="text-muted mr-1"><i class="icon-clock"></i>&nbsp; 01.01.2017</small>
	</div>
	<div>
		<small>#456/ЯСПГ</small>
	</div>
	<small class="text-muted mr-1"><i class="icon-control-forward"></i>&nbsp; <a href="#">перейти</a></small>
</div>
<div class="callout callout-warning m-0 py-1">
	<div class="pull-xs-right">
		<small class="text-muted mr-1"><i class="icon-clock"></i>&nbsp; 01.01.2017</small>
	</div>
	<div>
		<small>#456/ЯСПГ Доп. соглашение 1</small>
	</div>
	<small class="text-muted mr-1"><i class="icon-control-forward"></i>&nbsp; <a href="#">перейти</a></small>
</div>
<div class="callout callout-info m-0 py-1">
	<div class="pull-xs-right">
		<small class="text-muted mr-1"><i class="icon-clock"></i>&nbsp; Текущая версия</small>
	</div>
	<div>
		<small><strong>#456/ЯСПГ Доп. соглашение 2</strong></small>
	</div>
</div>
    ''';

    navTabContent.append(historyContentDiv);
  }

  void destroyHistory() {
    var historyTab = querySelector('#historyTab') as LIElement;
    var historyTabContent = querySelector('#history') as DivElement;

    if (historyTab != null) historyTab.remove();

    if (historyTabContent != null) historyTabContent.remove();

    var newActiveLink =
        querySelector('.aside-menu .nav-tabs li a') as AnchorElement;

    if (newActiveLink != null) newActiveLink.classes.add('active');

    var newActivePanel =
        querySelector('.aside-menu .tab-content div') as DivElement;

    if (newActivePanel != null) newActivePanel.classes.add('active');
  }

  @override
  void ngOnDestroy() {
    destroyHistory();
  }
}