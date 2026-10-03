import '../domain/usecases/adress/get_address_by_zipcode.dart';

late final GetAddressByZipcodeUsecase getAddressByZipcodeUsecase;

Future<void> initializeUseCases() async {

  getAddressByZipcodeUsecase = GetAddressByZipcodeUsecase();
}