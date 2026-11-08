import 'package:sqflite/sqflite.dart';

class DatabaseSeed {
  DatabaseSeed._();

  static Future<void> insertInitialData(DatabaseExecutor db) async {
    await db.insert('profile', _profile);

    for (final customer in _customers) {
      await db.insert('customers', customer);
    }

    for (final carrier in _carriers) {
      await db.insert('carriers', carrier);
    }

    for (final product in _products) {
      await db.insert('products', product);
    }
  }

  static const Map<String, Object?> _profile = {
    'name': 'DHIJOR CONFECCOES',
    'legal_name': 'DHIJOR CONFECCOES LTDA',
    'cnpj': '21601949000117',
    'state': 'SC',
    'city': 'Gaspar',
    'zip_code': '89114200',
    'street': 'Rua Gisele Brick Maraschi',
    'number': '20',
    'neighborhood': 'Santa Teresinha',
    'complement': 'casa',
    // Coordenadas de demonstração usadas pelo mock de Gaspar.
    'latitude': -26.931,
    'longitude': -48.958,
    'image_path': null,
  };

  static const List<Map<String, Object?>> _customers = [
    {
      'name': 'Academia Horizonte (demo)',
      'cnpj': '11111111000191',
      'legal_name': 'Academia Horizonte Demonstração LTDA',
      'phone': '00000000000',
      'email': 'academia@example.invalid',
      'establishment_type': 'academia',
      'state': 'SC',
      'city': 'Gaspar',
      'zip_code': '89110000',
      'street': 'Rua de Demonstração',
      'number': '100',
      'latitude': -26.931,
      'longitude': -48.958,
    },
    {
      'name': 'Escola Caminhos (demo)',
      'cnpj': '22222222000191',
      'legal_name': 'Escola Caminhos Demonstração LTDA',
      'phone': '00000000000',
      'email': 'escola@example.invalid',
      'establishment_type': 'escola',
      'state': 'SC',
      'city': 'Blumenau',
      'zip_code': '89010000',
      'street': 'Avenida de Demonstração',
      'number': '200',
      'latitude': -26.919,
      'longitude': -49.066,
    },
    {
      'name': 'Loja Esportiva Central (demo)',
      'cnpj': '33333333000191',
      'legal_name': 'Loja Esportiva Central Demonstração LTDA',
      'phone': '00000000000',
      'email': 'loja@example.invalid',
      'establishment_type': 'outro',
      'state': 'SC',
      'city': 'Joinville',
      'zip_code': '89201000',
      'street': 'Rua Comercial de Demonstração',
      'number': '300',
      'latitude': -26.304,
      'longitude': -48.846,
    },
  ];

  static const List<Map<String, Object?>> _carriers = [
    {
      'name': 'Rota Sul (demo)',
      'legal_name': 'Rota Sul Demonstração LTDA',
      'cnpj': '44444444000191',
      'phone': '00000000000',
      'email': 'rotasul@example.invalid',
      'cost_per_km': 2.50,
      'minimum_price': 15.00,
    },
    {
      'name': 'Entrega Vale (demo)',
      'legal_name': 'Entrega Vale Demonstração LTDA',
      'cnpj': '55555555000191',
      'phone': '00000000000',
      'email': 'entregavale@example.invalid',
      'cost_per_km': 3.10,
      'minimum_price': 18.00,
    },
    {
      'name': 'Carga Expressa (demo)',
      'legal_name': 'Carga Expressa Demonstração LTDA',
      'cnpj': '66666666000191',
      'phone': '00000000000',
      'email': 'cargaexpressa@example.invalid',
      'cost_per_km': 2.80,
      'minimum_price': 20.00,
    },
  ];

  static const List<Map<String, Object?>> _products = [
    {
      'name': 'Bola de futebol (demo)',
      'barcode': '2000000000011',
      'description': 'Produto fictício para demonstração.',
      'brand': 'Lince Demo',
      'sale_price': 89.90,
    },
    {
      'name': 'Camiseta esportiva (demo)',
      'barcode': '2000000000028',
      'description': 'Produto fictício para demonstração.',
      'brand': 'Lince Demo',
      'sale_price': 59.90,
    },
    {
      'name': 'Bola de vôlei (demo)',
      'barcode': '2000000000035',
      'description': 'Produto fictício para demonstração.',
      'brand': 'Lince Demo',
      'sale_price': 74.50,
    },
    {
      'name': 'Bola de futebol (demo)',
      'barcode': '2000000000011',
      'description': 'Produto fictício para demonstração.',
      'brand': 'Lince Demo',
      'sale_price': 89.90,
    },
    {
      'name': 'Bola de futebol (demo)',
      'barcode': '2000000000011',
      'description': 'Produto fictício para demonstração.',
      'brand': 'Lince Demo',
      'sale_price': 89.90,
    },
    {
      'name': 'Bola de futebol (demo)',
      'barcode': '2000000000011',
      'description': 'Produto fictício para demonstração.',
      'brand': 'Lince Demo',
      'sale_price': 89.90,
    },
    {
      'name': 'Bola de futebol (demo)',
      'barcode': '2000000000011',
      'description': 'Produto fictício para demonstração.',
      'brand': 'Lince Demo',
      'sale_price': 89.90,
    },
    {
      'name': 'Bola de futebol (demo)',
      'barcode': '2000000000011',
      'description': 'Produto fictício para demonstração.',
      'brand': 'Lince Demo',
      'sale_price': 89.90,
    },
    {
      'name': 'Bola de futebol (demo)',
      'barcode': '2000000000011',
      'description': 'Produto fictício para demonstração.',
      'brand': 'Lince Demo',
      'sale_price': 89.90,
    },
    {
      'name': 'Bola de futebol (demo)',
      'barcode': '2000000000011',
      'description': 'Produto fictício para demonstração.',
      'brand': 'Lince Demo',
      'sale_price': 89.90,
    },
    {
      'name': 'Bola de futebol (demo)',
      'barcode': '2000000000011',
      'description': 'Produto fictício para demonstração.',
      'brand': 'Lince Demo',
      'sale_price': 89.90,
    },
  ];
}
