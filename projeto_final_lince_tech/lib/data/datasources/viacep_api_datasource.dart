import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/address_model.dart';

class ViacepApiDatasource {
  Future<AddressModel> getByZipcode(String zipcode) async {
    final url = Uri.parse('https://viacep.com.br/ws/$zipcode/json/');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Erro ao consultar CEP');
    }

    final data = jsonDecode(response.body);

    print(data);

    return AddressModel.fromViaCepApiMap(data);
  }
}
