import 'package:angular2/core.dart';
import 'package:http_wrapper/http_wrapper.dart';
import 'package:config/config_service.dart';
import '../contract/general/contract_general_service.dart';
import '../contract/general/contract_general_model.dart';

/**
 * Сервис для всего раздела "Договоры"
 */
@Injectable()
class ContractsService {
  final ConfigService _config;
  final HttpWrapper _http;

  // режим редактирования
  bool writeEnabled = false;

  // режим создания договора
  bool creatingMode = false;

  // ID договора (актуален если creatingMode == false)
  String contractId;

  // модель общей информации о договоре
  ContractGeneralModel model;

  // http сервис работы с договором
  ContractGeneralService general;

  ContractsService(this._config, this._http) {
    general = new ContractGeneralService(
      this._http,
      this._config,
    );
  }
}
