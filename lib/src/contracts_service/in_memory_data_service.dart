import 'dart:async';
import 'dart:convert';

import 'package:angular2/core.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:json_object/json_object.dart';

@Injectable()
class InMemoryDataService extends MockClient {
  static final _initialContracts = new List<JsonObject>();
  static final List<JsonObject> _contractsDb = _initialContracts;

  InMemoryDataService() : super(_handler) {
    _initialContracts.add(new JsonObject.fromJsonString(JSON.encode({
      'id': 12,
      'name': 'Cnhjbntkmcndj ktrnhjctntq',
      'number': '12',
      'startDate': '',
      'finishDate': '',
      'contractorName': '',
      'currency': '',
      'amount': '',
      'vatIncluded': true,
      'constructionObjectName': '',
      'constructionObjectTitleName': '',
      'constructionObjectTitleCode': '',
      'description': ''
    })));
    _initialContracts.add(new JsonObject.fromJsonString(JSON.encode({
      'id': 13,
      'name': 'Cnhjbntkmcndj ktrnhjctntq',
      'number': '12',
      'startDate': '10.10.2015',
      'finishDate': '10.10.2015',
      'contractorName': 'Gjlhzlxbr gznm',
      'currency': '',
      'amount': '1000000',
      'vatIncluded': true,
      'constructionObjectName': '',
      'constructionObjectTitleName': '',
      'constructionObjectTitleCode': '',
      'description': ''
    })));
    _initialContracts.add(new JsonObject.fromJsonString(JSON.encode({
      'id': 14,
      'name': 'Cnhjbntkmcndj nhe,jghjdjlf',
      'number': '12',
      'startDate': '10.10.2015',
      'finishDate': '10.10.2015',
      'contractorName': 'Gjlhzlxbr gznm',
      'currency': '',
      'amount': '1000000',
      'vatIncluded': true,
      'constructionObjectName': '',
      'constructionObjectTitleName': '',
      'constructionObjectTitleCode': '',
      'description': ''
    })));
    _initialContracts.add(new JsonObject.fromJsonString(JSON.encode({
      'id': 15,
      'name': 'Cnhjbntkmcndj ufpjghjdjlf',
      'number': '12',
      'startDate': '10.10.2015',
      'finishDate': '10.10.2015',
      'contractorName': 'Gjlhzlxbr gznm',
      'currency': '',
      'amount': '1000000',
      'vatIncluded': true,
      'constructionObjectName': '',
      'constructionObjectTitleName': '',
      'constructionObjectTitleCode': '',
      'description': ''
    })));
    _initialContracts.add(new JsonObject.fromJsonString(JSON.encode({
      'id': 16,
      'name': 'Cnhjbntkmcndj gjlcj,ys[ gjvtotybq',
      'number': '12',
      'startDate': '10.10.2015',
      'finishDate': '10.10.2015',
      'contractorName': 'Gjlhzlxbr gznm',
      'currency': '1000000',
      'amount': '',
      'vatIncluded': true,
      'constructionObjectName': '',
      'constructionObjectTitleName': '',
      'constructionObjectTitleCode': '',
      'description': ''
    })));
    _initialContracts.add(new JsonObject.fromJsonString(JSON.encode({
      'id': 17,
      'name': 'Yfkjujdjt rjycekmnbhjdfybt',
      'number': '12',
      'startDate': '10.10.2015',
      'finishDate': '10.10.2015',
      'contractorName': 'Gjlhzlxbr gznm',
      'currency': '',
      'amount': '1000000',
      'vatIncluded': true,
      'constructionObjectName': '',
      'constructionObjectTitleName': '',
      'constructionObjectTitleCode': '',
      'description': ''
    })));
    _initialContracts.add(new JsonObject.fromJsonString(JSON.encode({
      'id': 18,
      'name': '<e[ufknthcrjt rjycekmnbhjdfybt',
      'number': '12',
      'startDate': '10.10.2015',
      'finishDate': '10.10.2015',
      'contractorName': 'Gjlhzlxbr gznm',
      'currency': '',
      'amount': '1000000',
      'vatIncluded': true,
      'constructionObjectName': '',
      'constructionObjectTitleName': '',
      'constructionObjectTitleCode': '',
      'description': ''
    })));
    _initialContracts.add(new JsonObject.fromJsonString(JSON.encode({
      'id': 19,
      'name': 'Djpdtltybt juhf;ltybq',
      'number': '12',
      'startDate': '10.10.2015',
      'finishDate': '10.10.2015',
      'contractorName': 'Gjlhzlxbr gznm',
      'currency': '',
      'amount': '1000000',
      'vatIncluded': true,
      'constructionObjectName': '',
      'constructionObjectTitleName': '',
      'constructionObjectTitleCode': '',
      'description': ''
    })));
    _initialContracts.add(new JsonObject.fromJsonString(JSON.encode({
      'id': 20,
      'name': 'Pfrkflrf aeylfvtynf',
      'number': '12',
      'startDate': '10.10.2015',
      'finishDate': '10.10.2015',
      'contractorName': 'Gjlhzlxbr gznm',
      'currency': '',
      'amount': '1000000',
      'vatIncluded': true,
      'constructionObjectName': '',
      'constructionObjectTitleName': '',
      'constructionObjectTitleCode': '',
      'description': ''
    })));
    _initialContracts.add(new JsonObject.fromJsonString(JSON.encode({
      'id': 21,
      'name': 'Nhfycgjhnbhjdrf ot,yz',
      'number': '12',
      'startDate': '10.10.2015',
      'finishDate': '10.10.2015',
      'contractorName': 'Gjlhzlxbr gznm',
      'currency': '',
      'amount': '1000000',
      'vatIncluded': true,
      'constructionObjectName': '',
      'constructionObjectTitleName': '',
      'constructionObjectTitleCode': '',
      'description': ''
    })));
    _initialContracts.add(new JsonObject.fromJsonString(JSON.encode({
      'id': 21,
      'name': 'Cnhjbntkmcndj ktrnhjctntq',
      'number': '12',
      'startDate': '10.10.2015',
      'finishDate': '10.10.2015',
      'contractorName': 'Gjlhzlxbr gznm',
      'currency': '',
      'amount': '1000000',
      'vatIncluded': true,
      'constructionObjectName': '',
      'constructionObjectTitleName': '',
      'constructionObjectTitleCode': '',
      'description': ''
    })));
    _initialContracts.add(new JsonObject.fromJsonString(JSON.encode({
      'id': 22,
      'name': 'Cnhjbntkmcndj nhe,jghjdjlf',
      'number': '12',
      'startDate': '10.10.2015',
      'finishDate': '10.10.2015',
      'contractorName': 'Gjlhzlxbr gznm',
      'currency': '',
      'amount': '1000000',
      'vatIncluded': true,
      'constructionObjectName': '',
      'constructionObjectTitleName': '',
      'constructionObjectTitleCode': '',
      'description': ''
    })));
    _initialContracts.add(new JsonObject.fromJsonString(JSON.encode({
      'id': 23,
      'name': 'Cnhjbntkmcndj ufpjghjdjlf',
      'number': '12',
      'startDate': '10.10.2015',
      'finishDate': '10.10.2015',
      'contractorName': 'Gjlhzlxbr gznm',
      'currency': '',
      'amount': '1000000',
      'vatIncluded': true,
      'constructionObjectName': '',
      'constructionObjectTitleName': '',
      'constructionObjectTitleCode': '',
      'description': ''
    })));
    _initialContracts.add(new JsonObject.fromJsonString(JSON.encode({
      'id': 24,
      'name': 'Cnhjbntkmcndj gjlcj,ys[ gjvtotybq',
      'number': '12',
      'startDate': '10.10.2015',
      'finishDate': '10.10.2015',
      'contractorName': 'Gjlhzlxbr gznm',
      'currency': '',
      'amount': '1000000',
      'vatIncluded': true,
      'constructionObjectName': '',
      'constructionObjectTitleName': '',
      'constructionObjectTitleCode': '',
      'description': ''
    })));
  }

  static Future<Response> _handler(Request request) async {
    var data;
    switch (request.method) {
      case 'GET':
        final id =
            int.parse(request.url.pathSegments.last, onError: (_) => null);
        if (id != null) {
          data = _contractsDb.firstWhere(
              (contract) => contract.id == id); // throws if no match
        } else {
          data = _contractsDb;
        }
        break;
      case 'POST':
        var newContract = new JsonObject();
        newContract.id = '33';
        newContract.name = '33';
        _contractsDb.add(newContract);
        data = newContract;
        break;
      case 'PUT':
        var contractChanges =
            new JsonObject.fromJsonString(JSON.encode(request.body));
        var targetContract =
            _contractsDb.firstWhere((h) => h.id == contractChanges.id);
        targetContract.name = contractChanges.name;
        data = targetContract;
        break;
      case 'DELETE':
        var id = int.parse(request.url.pathSegments.last);
        _contractsDb.removeWhere((contract) => contract.id == id);
        // No data, so leave it as null.
        break;
      default:
        throw 'Unimplemented HTTP method ${request.method}';
    }

    return new Response(JSON.encode({'result': data}), 200,
        headers: {'content-type': 'application/json'});
  }
}
