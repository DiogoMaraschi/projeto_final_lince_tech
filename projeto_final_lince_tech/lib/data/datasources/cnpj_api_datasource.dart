import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/cnpj_model.dart';

class CnpjApiDatasource {
  Future<CnpjModel> getCnpj(String cnpj) async {
    final url = Uri.parse('https://brasilapi.com.br/api/cnpj/v1/$cnpj');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Erro ao consultar CNPJ');
    }

    final data = jsonDecode(response.body);

    return CnpjModel.fromMap(data);
  }
}
