import '../repository.dart';

class CaptureImageUsecase {
  final ImagePickerRepository repository;

  CaptureImageUsecase({required this.repository});

  Future<String?> call() async {
    return repository.captureImage();
  }
}
