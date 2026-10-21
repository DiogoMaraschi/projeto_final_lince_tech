import '../../../entities/profile.dart';
import '../repository.dart';

class CreateProfileUsecase {
  final ProfileRepository repository;
  
  CreateProfileUsecase({required this.repository});
  
  Future<int> call(Profile profile) async{
    return repository.insert(profile);
  }
}