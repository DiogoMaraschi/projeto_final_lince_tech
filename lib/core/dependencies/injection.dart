import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../modules/address/datasources/brasil_api_datasource.dart';
import '../../modules/address/datasources/geocoding_datasource.dart';
import '../../modules/address/usecases/get_location_by_address_usecase.dart';
import '../../modules/imagePicker/datasources/camera_datasource.dart';
import '../../modules/cnpj/datasources/cnpj_api_datasource.dart';
import '../../modules/address/datasources/viacep_api_datasource.dart';
import '../../modules/customer/repository.dart';
import '../../modules/imagePicker/repository.dart';
import '../../modules/carrier/repository.dart';
import '../../modules/cnpj/repository.dart';
import '../../modules/customer/usecases/delete_customer_usecase.dart';
import '../../modules/customer/usecases/update_customer_usecase.dart';
import '../../modules/imagePicker/usecases/pick_image_from_galery_usecase.dart';
import '../../modules/product/repository.dart';
import '../../modules/address/usecases/get_address_by_zipcode.dart';
import '../../modules/address/repository.dart';
import '../../modules/imagePicker/usecases/capture_image_usecase.dart';
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
import '../../modules/profile/repository.dart';
import '../../modules/profile/usecases/create_profile_usecase.dart';
import '../../modules/profile/usecases/get_profile_usecase.dart';
import '../../modules/profile/usecases/update_profile_usecase.dart';
import '../database/database_helper.dart';
import '../storage/preferences_service.dart';

class Injection {
  late final CreateProductUsecase createProductUsecase;
  late final GetCnpjUsecase getCnpjUsecase;
  late final GetAddressByZipcodeUsecase getAddressByZipcodeUsecase;
  late final GetLocationByAddressUsecase getLocationByAddressUsecase;
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
  late final UpdateCustomerUsecase updateCustomerUsecase;
  late final DeleteCustomerUsecase deleteCustomerUsecase;
  late final PickImageFromGaleryUsecase pickImageFromGaleryUsecase;
  late final CreateProfileUsecase createProfileUsecase;
  late final UpdateProfileUsecase updateProfileUsecase;
  late final GetProfileUsecase getProfileUsecase;

  late final PreferencesService preferencesService;

  Future<void> inicialize() async {
    //DATABASE
    final database = DatabaseHelper();
    // await database.resetDatabase();

    //SHARED PREFERENCE
    final preferences = await SharedPreferences.getInstance();
    preferencesService = PreferencesService(preferences: preferences);

    final geocoding = Geocoding();

    //DATASOURCES
    final cnpjApiDatasource = CnpjApiDatasource();
    final brasilApiDatasource = BrasilApiDatasource();
    final viacepApiDatasource = ViacepApiDatasource();
    final cameraDatasource = ImagePickerDatasource();
    final geocodingDatasource = GeocodingDatasource(geocoding: geocoding);

    //REPOSITORIES
    final productRepository = ProductRepositoryImpl(databaseHelper: database);
    final cnpjRepository = CnpjRepositoryImpl(dataSource: cnpjApiDatasource);
    final addressRepository = AddressRepositoryImpl(
      brasilApiDatasource: brasilApiDatasource,
      viacepApiDatasource: viacepApiDatasource,
      geocodingDatasource: geocodingDatasource,
    );
    final profileRepository = ProfileRepositoryImpl(databaseHelper: database);

    final imagePickerRepository = ImagePickerRepositoryImpl(
      datasource: cameraDatasource,
    );
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
    captureImageUsecase = CaptureImageUsecase(
      repository: imagePickerRepository,
    );
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
    updateCustomerUsecase = UpdateCustomerUsecase(
      repository: customerRepository,
    );
    deleteCustomerUsecase = DeleteCustomerUsecase(
      repository: customerRepository,
    );
    pickImageFromGaleryUsecase = PickImageFromGaleryUsecase(
      repository: imagePickerRepository,
    );
    getLocationByAddressUsecase = GetLocationByAddressUsecase(
      repository: addressRepository,
    );
    createProfileUsecase = CreateProfileUsecase(repository: profileRepository);
    updateProfileUsecase = UpdateProfileUsecase(repository: profileRepository);
    getProfileUsecase = GetProfileUsecase(repository: profileRepository);
  }
}
