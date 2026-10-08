import '../../modules/camera/repository.dart';
import '../datasources/camera_datasource.dart';

class CameraRepositoryImpl implements CameraRepository {
  final CameraDatasource datasource;

  CameraRepositoryImpl({required this.datasource});

  Future<String?> captureImage() => datasource.captureImage();
}
