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

  ContractsService(this._http, this._config) {
    _logger = new LoggerService(_config);
  }

  /**
   * Получение списка договоров
   */
  Future<List<JsonObject>> getContracts() async {
    _logger.trace('Requesting contracts. Url: ${_config.helper.contractsUrl}');

    Response response = null;

    try {
      print(123123);
      print(_config);
      print(_config.helper);
      print(_config.helper.contractsUrl);
      response = await _http.get(
        'http://localhost:5000/contracts',
        /*_config.helper.contractsUrl,*/
        headers: {'Content-Type': 'application/json'});
      print(234234);
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
    Response response = null;

    _logger.trace('Requesting contract. Url: ${_config.helper.contractsUrl}/$contractId');
    try {
      response = await _http.get(
        /*${_config.helper.contractsUrl}/$contractId',*/
        'http://localhost:5000/contracts',
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
    _logger.trace('Creating contract ${model.toJsonString()}');

    print(model.toJsonString());

    try {
      await _http.post(
        /*_config.helper.contractsUrl,*/
        'http://localhost:5000/contracts',
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
    _logger.trace('Editing contract ${model.toJsonString()}');

    print(model.toJsonString());

    try {
      await _http.put(
        /*_config.helper.contractsUrl,*/
        'http://localhost:5000/contracts',
        headers: {'Content-Type': 'application/json'},
        body: model.toJsonString());
      _logger.trace('Contract ${model.name} edited');
    } catch (e) {
      _logger.error('Failed to edit contract: $e');

      throw new Exception('Failed to edit contract. Cause: $e');
    }
  }
}