import '../repository.dart';

class PickImageFromGaleryUsecase {
  final ImagePickerRepository repository;

  PickImageFromGaleryUsecase({required this.repository});

  Future<String?> call() async{
    return repository.pickImageFromGalery();
  }


}