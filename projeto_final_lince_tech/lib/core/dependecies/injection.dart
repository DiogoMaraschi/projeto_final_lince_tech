import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/cnpj_api_datasource.dart';
import '../../domain/repositories/cnpj_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/cnpj/get_cnpj_usecase.dart';
import '../../domain/usecases/products/create_product_usecase.dart';
import '../database/database_helper.dart';
import '../storage/preferences_service.dart';

class Injection {
  late final CreateProductUsecase createProductUsecase;
  late final GetCnpjUsecase getCnpjUsecase;

  Future<void> inicialize() async {
    //DATABASE
    final database = DatabaseHelper();

    //SHARED PREFERENCE
    final preferences = await SharedPreferences.getInstance();
    final preferencesService = PreferencesService(preferences: preferences);

    //PRODUCT
    final productRepository = ProductRepositoryImpl(databaseHelper: database);

    createProductUsecase = CreateProductUsecase(repository: productRepository);

    //CNPJ
    final cnpjApiDatasource = CnpjApiDatasource();

    final cnpjRepository = CnpjRepositoryImpl(dataSource: cnpjApiDatasource);

    getCnpjUsecase = GetCnpjUsecase(repository: cnpjRepository);
  }
}
