import 'package:angular2/core.dart';
import 'package:http_wrapper/http_wrapper.dart';
import 'package:config/config_service.dart';
import '../contract/general/contract_general_service.dart';

/**
 * Сервис для всего раздела "Договоры"
 */
@Injectable()
class ContractsService {
  final ConfigService _config;
  final HttpWrapper _http;

  bool writeEnabled = false;

  ContractGeneralService general;

  ContractsService(this._config, this._http) {
    general = new ContractGeneralService(this._http, this._config,);
  }
}
