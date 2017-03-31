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

  ContractGeneralService(this._http, this._config) {
    _logger = new LoggerService(_config);
  }

  /**
   * Получение списка договоров
   */
  Future<List<ContractGeneralModel>> getContracts() async {
    _logger.trace('Requesting contracts. Url: ${ _config.helper.contractsUrl }');

    Response response = null;

    try {
      response = await _http
          .get(_config.helper.contractsUrl, headers: {'Content-Type': 'application/json'});
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
    Response response = null;

    _logger.trace('Requesting contract. Url: ${ _config.helper.contractsUrl }/$id');

    try {
      response = await _http.get('${ _config.helper.contractsUrl }/$id',
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
    Response response = null;

    var jsonString =  JSON.encode(model.toJson());

    _logger.trace('Creating contract $jsonString');

    try {
      response = await _http.post(_config.helper.contractsUrl,
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
    var jsonString =  JSON.encode(model.toJson());

    _logger.trace('Updating contract $jsonString');

    try {
      await _http.put(_config.helper.contractsUrl,
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
    _logger.trace('Removing contract. Url: ${ _config.helper.contractsUrl }/$id');

    try {
      await _http.delete('${ _config.helper.contractsUrl }/$id',
          headers: {'Content-Type': 'application/json'});
      _logger.trace('Contract $id removed');
    } catch (e) {
      _logger.error('Failed to remove contract: $e');

      throw new Exception('Failed to remove contract. Cause: $e');
    }
  }
}