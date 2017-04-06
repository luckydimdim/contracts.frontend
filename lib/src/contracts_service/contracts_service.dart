import 'package:angular2/core.dart';
import 'package:http/http.dart';
import 'package:config/config_service.dart';
import '../contract/general/contract_general_service.dart';

/**
 * Сервис для всего раздела "Договоры"
 */
@Injectable()
class ContractsService {
  final Client _http;
  final ConfigService _config;

  bool writeEnabled = false;

  ContractGeneralService general;

  ContractsService(this._http, this._config) {
    general = new ContractGeneralService(this._http, this._config);
  }
}
