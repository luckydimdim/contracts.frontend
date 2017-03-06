import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:angular2/core.dart';

import 'package:config/config_service.dart';
import 'package:json_object/json_object.dart';
import 'package:logger/logger_service.dart';

import '../general/contract_general_create_view_model.dart';
import '../general/contract_general_edit_view_model.dart';

/**
 * Работа с БД для раздела "Договоры"
 */
@Injectable()
class ContractsService {
  final Client _http;
  final ConfigService _config;
  LoggerService _logger;
  String _backendUrl = null;
  bool _initialized = false;

  ContractsService(this._http, this._config) {
    _logger = new LoggerService(_config);
  }

  _init() async {
    String backendScheme = await _config.Get<String>('backend_scheme');
    String backendBaseUrl = await _config.Get<String>('backend_base_url');
    String backendPort = await _config.Get<String>('backend_port');
    String backendContracts = await _config.Get<String>('backend_contracts');

    _backendUrl = '$backendScheme://$backendBaseUrl:$backendPort/$backendContracts';

    _initialized = true;
  }

  /**
   * Получение списка договоров
   */
  Future<List<JsonObject>> getContracts() async {
    if (!_initialized)
      await _init();

    _logger.trace('Requesting contracts. Url: ${_config.helper.contractsUrl}');

    Response response = null;

    try {
      response = await _http.get(
        /*'http://localhost:5000/contracts',*/
        _backendUrl,
        /*_config.helper.contractsUrl,*/
        headers: {'Content-Type': 'application/json'});
    } catch (e) {
      _logger.error('Failed to get contract list: $e');

      throw new Exception('Failed to get contract list. Cause: $e');
    }

    _logger.trace('Contracts requested: $response.');

    return JSON.decode(response.body)['data'];
  }

  /**
   * Получение договора по его id
   */
  Future<JsonObject> getContract(int contractId) async {
    if (!_initialized)
      await _init();

    Response response = null;

    _logger.trace('Requesting contract. Url: ${_config.helper.contractsUrl}/$contractId');
    try {
      response = await _http.get(
        /*${_config.helper.contractsUrl}/$contractId',*/
        /*'http://localhost:5000/contracts',*/
        _backendUrl,
        headers: {'Content-Type': 'application/json'});
    } catch (e) {
      _logger.error('Failed to get contract general: $e');

      throw new Exception('Failed to get contract general. Cause: $e');
    }

    _logger.trace('Contract requested: $response.');

    return JSON.decode(response.body)['data'];
  }

  /**
   * Создание нового договора
   */
  createContract(ContractGeneralCreateViewModel model) async {
    if (!_initialized)
      await _init();

    _logger.trace('Creating contract ${model.toJsonString()}');

    print(model.toJsonString());

    try {
      await _http.post(
        /*_config.helper.contractsUrl,*/
        /*'http://localhost:5000/contracts',*/
        _backendUrl,
        headers: {'Content-Type': 'application/json'},
        body: model.toJsonString());

      _logger.trace('Contract ${model.name} created');

    } catch (e) {
      print('Failed to create contract: $e');

      throw new Exception('Failed to create contract. Cause: $e');
    }
  }

  /**
   * Изменение данных договора
   */
  editContract(ContractGeneralEditViewModel model) async {
    if (!_initialized)
      await _init();

    _logger.trace('Editing contract ${model.toJsonString()}');

    print(model.toJsonString());

    try {
      await _http.put(
        /*_config.helper.contractsUrl,*/
        /*'http://localhost:5000/contracts',*/
        _backendUrl,
        headers: {'Content-Type': 'application/json'},
        body: model.toJsonString());
      _logger.trace('Contract ${model.name} edited');
    } catch (e) {
      _logger.error('Failed to edit contract: $e');

      throw new Exception('Failed to edit contract. Cause: $e');
    }
  }
}