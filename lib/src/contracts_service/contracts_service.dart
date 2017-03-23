import 'package:angular2/core.dart';
import 'package:contracts/src/contract/src/general/contract_general_service.dart';

/**
 * Сервис для всего раздела "Договоры"
 */
@Injectable()
class ContractsService {
  bool writeEnabled = false;

  ContractGeneralService general = null;

  ContractsService(this.general);
}
