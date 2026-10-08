import '../repository.dart';

class CaptureImageUsecase {
  final CameraRepository repository;

  CaptureImageUsecase({required this.repository});

  Future<String?> call() async {
    return repository.captureImage();
  }
}
