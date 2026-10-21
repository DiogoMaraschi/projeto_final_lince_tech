import '../../../entities/profile.dart';
import '../repository.dart';

class GetProfileUsecase {
  final ProfileRepository repository;

  GetProfileUsecase({required this.repository});

  Future<Profile?> call()async{
    return repository.getProfile();
  }
}