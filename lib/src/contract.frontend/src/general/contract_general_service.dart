import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:angular2/core.dart';

import 'package:config/config_service.dart';
import 'package:json_object/json_object.dart';
import 'package:logger/logger_service.dart';

import '../general/contract_general_model.dart';

/**
 * Работа с БД для раздела "Договоры / Общая информация"
 */
@Injectable()
class ContractGeneralService {
  final Client _http;
  final ConfigService _config;
  LoggerService _logger;
  String _backendUrl = null;
  bool _initialized = false;

  ContractGeneralService(this._http, this._config) {
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

    return JSON.decode(response.body);
  }

  /**
   * Получение договора по его id
   */
  Future<ContractGeneralModel> getContract(String contractId) async {
    if (!_initialized)
      await _init();

    Response response = null;

    _logger.trace('Requesting contract. Url: $_backendUrl/$contractId');

    try {
      response = await _http.get(
        '$_backendUrl/$contractId',
        headers: {'Content-Type': 'application/json'});
    } catch (e) {
      _logger.error('Failed to get contract general: $e');

      throw new Exception('Failed to get contract general. Cause: $e');
    }

    _logger.trace('Contract requested: $response.');

    dynamic json = JSON.decode(response.body);

    return new ContractGeneralModel.fromJson(json);
  }

  /**
   * Создание нового договора
   */
  Future<String> createContract() async {
    if (!_initialized)
      await _init();

    Response response = null;

    _logger.trace('Creating contract');

    try {
      response = await _http.post(
        _backendUrl,
        headers: {'Content-Type': 'application/json'});

      _logger.trace('Contract created');

    } catch (e) {
      print('Failed to create contract: $e');

      throw new Exception('Failed to create contract. Cause: $e');
    }

    return response.body;
  }

  /**
   * Изменение данных договора
   */
  updateContract(ContractGeneralModel model) async {
    if (!_initialized)
      await _init();

    _logger.trace('Editing contract ${model.toJsonString()}');

    try {
      await _http.put(
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