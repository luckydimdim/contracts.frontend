import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:angular2/core.dart';

import 'package:config/config_service.dart';
import 'package:logger/logger_service.dart';

import '../general/contract_general_model.dart';

/**
 * Работа с web-сервисом. Раздел "Договоры / Общая информация"
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

    _backendUrl =
        '$backendScheme://$backendBaseUrl:$backendPort/$backendContracts';

    _initialized = true;
  }

  /**
   * Получение списка договоров
   */
  Future<List<ContractGeneralModel>> getContracts() async {
    if (!_initialized) await _init();

    _logger.trace('Requesting contracts. Url: $_backendUrl');

    Response response = null;

    try {
      response = await _http
          .get(_backendUrl, headers: {'Content-Type': 'application/json'});
    } catch (e) {
      _logger.error('Failed to get contract list: $e');

      throw new Exception('Failed to get contract list. Cause: $e');
    }

    _logger.trace('Contracts requested: $response.');

    var result = new List<ContractGeneralModel>();

    var list = JSON.decode(response.body);

    for (var json in list ) {
      result.add(new ContractGeneralModel.fromJson(json));
    }

    return result;
  }

  /**
   * Получение одного договора по его id
   */
  Future<ContractGeneralModel> getContract(String id) async {
    if (!_initialized) await _init();

    Response response = null;

    _logger.trace('Requesting contract. Url: $_backendUrl/$id');

    try {
      response = await _http.get('$_backendUrl/$id',
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      _logger.error('Failed to get contract general: $e');

      throw new Exception('Failed to get contract general. Cause: $e');
    }

    _logger.trace('Contract requested: $response.');

    var json = JSON.decode(response.body);

    var result = new ContractGeneralModel.fromJson(json);

    return result;
  }

  /**
   * Создание нового договора
   */
  Future<String> createContract(ContractGeneralModel model) async {
    if (!_initialized) await _init();

    Response response = null;

    var jsonString =  JSON.encode(model.toJson());

    _logger.trace('Creating contract $jsonString');

    try {
      response = await _http.post(_backendUrl,
          body: jsonString,
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
    if (!_initialized) await _init();

    var jsonString =  JSON.encode(model.toJson());

    _logger.trace('Updating contract $jsonString');

    try {
      await _http.put(_backendUrl,
          headers: {'Content-Type': 'application/json'},
          body: jsonString);
      _logger.trace('Contract ${model.name} successfuly updated');
    } catch (e) {
      _logger.error('Failed to update contract: $e');

      throw new Exception('Failed to update contract. Cause: $e');
    }
  }

  /**
   * Удаление договора
   */
  deleteContract(String id) async {
    if (!_initialized) await _init();

    _logger.trace('Removing contract. Url: $_backendUrl/$id');

    try {
      await _http.delete('$_backendUrl/$id',
          headers: {'Content-Type': 'application/json'});
      _logger.trace('Contract $id removed');
    } catch (e) {
      _logger.error('Failed to remove contract: $e');

      throw new Exception('Failed to remove contract. Cause: $e');
    }
  }
}
