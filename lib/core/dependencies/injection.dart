import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/brasil_api_datasource.dart';
import '../../data/datasources/camera_datasource.dart';
import '../../data/datasources/cnpj_api_datasource.dart';
import '../../data/datasources/viacep_api_datasource.dart';
import '../../data/repositories/address_repository_impl.dart';
import '../../modules/customer/repository.dart';
import '../../data/repositories/customer_repository_impl.dart';
import '../../modules/camera/repository.dart';
import '../../data/repositories/camera_repository_impl.dart';
import '../../modules/carrier/repository.dart';
import '../../data/repositories/carrier_repository_impl.dart';
import '../../modules/cnpj/repository.dart';
import '../../data/repositories/cnpj_repository_impl.dart';
import '../../modules/product/repository.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../modules/address/usecases/get_address_by_zipcode_usecase.dart';
import '../../modules/address/repository.dart';
import '../../modules/camera/usecases/capture_image_usecase.dart';
import '../../modules/carrier/usecases/create_carrier_usecase.dart';
import '../../modules/carrier/usecases/delete_carrier_usecase.dart';
import '../../modules/carrier/usecases/get_all_carriers_usecase.dart';
import '../../modules/carrier/usecases/update_carrier_usecase.dart';
import '../../modules/cnpj/usecases/get_cnpj_usecase.dart';
import '../../modules/customer/usecases/create_customer_usecase.dart';
import '../../modules/customer/usecases/get_all_customers_usecase.dart';
import '../../modules/product/usecases/create_product_usecase.dart';
import '../../modules/product/usecases/delete_product_usecase.dart';
import '../../modules/product/usecases/get_all_products_usecase.dart';
import '../../modules/product/usecases/update_product_usecase.dart';
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
  late final DeleteCarrierUsecase deleteCarrierUsecase;
  late final CreateCustomerUsecase createCustomerUsecase;
  late final GetAllCustomersUsecase getAllCustomersUsecase;

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
    final addressRepository = AddressRepositoryImpl(
      brasilApiDatasource: brasilApiDatasource,
      viacepApiDatasource: viacepApiDatasource,
    );

    final cameraRepository = CameraRepositoryImpl(datasource: cameraDatasource);
    final carrierRepository = CarrierRepositoryImpl(databaseHelper: database);
    final customerRepository = CustomerRepositoryImpl(databaseHelper: database);

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
    deleteCarrierUsecase = DeleteCarrierUsecase(repository: carrierRepository);
    createCustomerUsecase = CreateCustomerUsecase(
      repository: customerRepository,
    );
    getAllCustomersUsecase = GetAllCustomersUsecase(
      repository: customerRepository,
    );
  }
}
