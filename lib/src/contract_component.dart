import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'dart:html';

import 'package:resources_loader/resources_loader.dart';

import 'general/contract_general_component.dart';
import 'doc_settings/contract_doc_settings_component.dart';
import 'materials/contract_materials_component.dart';
import 'payments/contract_payments_component.dart';
import 'payments_schedule/contract_payments_schedule_component.dart';
import 'works/contract_works_component.dart';
import 'works_to_budget_binding/works_to_budget_binding_component.dart';
import 'works_to_title_binding/works_to_title_binding_component.dart';
import 'materials_to_budget_binding/materials_to_budget_binding_component.dart';
import 'materials_to_title_binding/materials_to_title_binding_component.dart';
import 'contract_budget/contract_budget_component.dart';
import 'contract_layout/contract_layout_component.dart';

@Component(
    selector: 'contract',
    templateUrl: 'contract_component.html',
    directives: const [RouterOutlet, ContractLayoutComponent])
@RouteConfig(const [
  ContractGeneralComponent.route,
  ContractDocSettingsComponent.route,
  ContractMaterialsComponent.route,
  ContractPaymentsComponent.route,
  WorksToBudgetBindingComponent.route,
  ContractPaymentsScheduleComponent.route,
  WorksToTitleBindingComponent.route,
  MaterialsToBudgetBindingComponent.route,
  MaterialsToTitleBindingComponent.route,
  ContractWorksComponent.route,
  ContractBudgetComponent.route])
class ContractComponent implements OnInit, OnDestroy {
  static const String route_name = 'Contract';
  static const String route_path = 'contract/...';
  static const Route route = const Route(
      path: ContractComponent.route_path,
      component: ContractComponent,
      name: ContractComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  ContractComponent(this._router, this._resourcesLoaderService) {}

  @override
  void ngOnInit() {
    breadcrumbInit();
    createHistoryTab();
  }

  void breadcrumbInit() {
    var  breadcrumbContent = querySelector('#breadcrumbContent') as OListElement;

    if (breadcrumbContent == null)
      return;

    breadcrumbContent.innerHtml = '''
            <li class="breadcrumb-item"><a href="#/master/dashboard">Главная</a></li>
    ''';
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
    querySelector('.aside-menu .nav-tabs li a[href="#history"]') as AnchorElement;
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

    if (navTabs == null || navTabContent == null)
      return;

    var historyTab = new LIElement()
      ..className = 'nav-item'
      ..id = 'historyTab';
    var historyAnchor = new AnchorElement(href: '#history')
      ..className = 'nav-link';
    historyAnchor.setAttribute('data-toggle', 'tab');
    historyAnchor.setAttribute('role', 'tab');

    var historyCursive = new Element.tag('i')
      ..className = 'fa fa-history';

    historyAnchor.append(historyCursive);
    historyTab.append(historyAnchor);
    navTabs.append(historyTab);

    var historyContentDiv = new DivElement()
      ..className = 'tab-pane'
      ..id = 'history';
    historyContentDiv.setAttribute('role', 'tabpanel');
    historyContentDiv.setAttribute('aria-expanded', 'false');

    historyContentDiv.classes.add('p-1');

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

    if (historyTab != null)
      historyTab.remove();

    if (historyTabContent != null)
      historyTabContent.remove();

    var newActiveLink =
    querySelector('.aside-menu .nav-tabs li a')
    as AnchorElement;

    if (newActiveLink != null)
      newActiveLink.classes.add('active');

    var newActivePanel =
    querySelector('.aside-menu .tab-content div')
    as DivElement;

    if (newActivePanel != null)
      newActivePanel.classes.add('active');
  }

  @override
  void ngOnDestroy() {
    destroyHistory();
  }
}
