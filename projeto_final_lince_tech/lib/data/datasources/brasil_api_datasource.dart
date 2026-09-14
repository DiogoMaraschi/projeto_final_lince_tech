import 'dart:convert';

import '../models/adress_model.dart';
import 'package:http/http.dart' as http;

class BrasilApiDatasource {
  Future<AdressModel> getByZipcode(String zipcode) async {
    final url = Uri.parse('https://brasilapi.com.br/api/cep/v1/$zipcode');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Erro ao consultar CEP');
    }

    final data = jsonDecode(response.body);

    return AdressModel.fromMap(data);
  }
}
