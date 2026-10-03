import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/brasil_api_datasource.dart';
import '../../data/datasources/camera_datasource.dart';
import '../../data/datasources/cnpj_api_datasource.dart';
import '../../data/datasources/viacep_api_datasource.dart';
import '../../domain/repositories/address_repository.dart';
import '../../domain/repositories/camera_repository.dart';
import '../../domain/repositories/carrier_repository.dart';
import '../../domain/repositories/cnpj_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/adress/get_address_by_zipcode.dart';
import '../../domain/usecases/capture_image_usecase.dart';
import '../../domain/usecases/carriers/create_carrier_usecase.dart';
import '../../domain/usecases/carriers/get_all_carriers_usecase.dart';
import '../../domain/usecases/carriers/update_carrier_usecase.dart';
import '../../domain/usecases/cnpj/get_cnpj_usecase.dart';
import '../../domain/usecases/products/create_product_usecase.dart';
import '../../domain/usecases/products/delete_product_usecase.dart';
import '../../domain/usecases/products/get_all_products_usecase.dart';
import '../../domain/usecases/products/update_product_usecase.dart';
import '../database/database_helper.dart';
import '../storage/preferences_service.dart';

class Injection {
  late final CreateProductUsecase createProductUsecase;
  late final GetCnpjUsecase getCnpjUsecase;
  late final GetAddressByZipcodeUsecase getAddressByZipcodeUsecase;
  late final CaptureImageUsecase captureImageUsecase;
  late final GetAllProductsUsecase getAllProductsUsecase;
  late final UpdateProductUsecase updateProductUsecase;
  late final DeleteProductUsecase deleteProductUsecase;
  late final CreateCarrierUsecase createCarrierUsecase;
  late final GetAllCarriersUsecase getAllCarriersUsecase;
  late final UpdateCarrierUsecase updateCarrierUsecase;

  Future<void> inicialize() async {
    //DATABASE
    final database = DatabaseHelper();
     await database.resetDatabase();

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
    final addressRepository = AdressRepositoryImpl(
      brasilApiDatasource: brasilApiDatasource,
      viacepApiDatasource: viacepApiDatasource,
      databaseHelper: database,
    );
    final cameraRepository = CameraRepositoryImpl(datasource: cameraDatasource);
    final carrierRepository = CarrierRepositoryImpl(databaseHelper: database);

    //USECASES
    createProductUsecase = CreateProductUsecase(repository: productRepository);
    getAllProductsUsecase = GetAllProductsUsecase(
      repository: productRepository,
    );
    getCnpjUsecase = GetCnpjUsecase(repository: cnpjRepository);
    getAddressByZipcodeUsecase = GetAddressByZipcodeUsecase(
      repository: addressRepository,
    );
    captureImageUsecase = CaptureImageUsecase(repository: cameraRepository);
    updateProductUsecase = UpdateProductUsecase(repository: productRepository);
    deleteProductUsecase = DeleteProductUsecase(repository: productRepository);
    createCarrierUsecase = CreateCarrierUsecase(repository: carrierRepository);
    getAllCarriersUsecase = GetAllCarriersUsecase(
      repository: carrierRepository,
    );
    updateCarrierUsecase = UpdateCarrierUsecase(repository: carrierRepository);
  }
}
