import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/brasil_api_datasource.dart';
import '../../data/datasources/camera_datasource.dart';
import '../../data/datasources/cnpj_api_datasource.dart';
import '../../data/datasources/viacep_api_datasource.dart';
import '../../domain/repositories/adress_repository.dart';
import '../../domain/repositories/camera_repository.dart';
import '../../domain/repositories/cnpj_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/adress/get_adress_usecase.dart';
import '../../domain/usecases/capture_image_usecase.dart';
import '../../domain/usecases/cnpj/get_cnpj_usecase.dart';
import '../../domain/usecases/products/create_product_usecase.dart';
import '../../domain/usecases/products/get_products_usecase.dart';
import '../database/database_helper.dart';
import '../storage/preferences_service.dart';

class Injection {
  late final CreateProductUsecase createProductUsecase;
  late final GetCnpjUsecase getCnpjUsecase;
  late final GetAdressUsecase getAdressUsecase;
  late final CaptureImageUsecase captureImageUsecase;
  late final GetProductsUsecase getProductsUsecase;

  Future<void> inicialize() async {
    //DATABASE
    final database = DatabaseHelper();
    //await database.resetDatabase();

    //SHARED PREFERENCE
    final preferences = await SharedPreferences.getInstance();
    final preferencesService = PreferencesService(preferences: preferences);

    //DATASOURCES
    final cnpjApiDatasource = CnpjApiDatasource();
    final brasilApiDatasource = BrasilApiDatasource();
    final viacepApiDatasource = ViacepApiDatasource();
    final cameraDatasource = CameraDatasource();

    //REPOSITORIES
    final productRepository = ProductRepositoryImpl(databaseHelper: database);
    final cnpjRepository = CnpjRepositoryImpl(dataSource: cnpjApiDatasource);
    final adressRepository = AdressRepositoryImpl(
      brasilApiDatasource: brasilApiDatasource,
      viacepApiDatasource: viacepApiDatasource,
    );
    final cameraRepository = CameraRepositoryImpl(datasource: cameraDatasource);

    //USECASES
    createProductUsecase = CreateProductUsecase(repository: productRepository);
    getProductsUsecase = GetProductsUsecase(repository: productRepository);
    getCnpjUsecase = GetCnpjUsecase(repository: cnpjRepository);
    getAdressUsecase = GetAdressUsecase(repository: adressRepository);
    captureImageUsecase = CaptureImageUsecase(repository: cameraRepository);
  }
}
