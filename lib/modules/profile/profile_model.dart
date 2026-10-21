import '../../entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    super.id,
    required super.name,
    super.legalName,
    required super.cnpj,
    required super.state,
    required super.city,
    required super.zipCode,
    required super.street,
    required super.number,
    super.neighborhood,
    super.complement,
    required super.latitude,
    required super.longitude,
    super.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'legal_name': legalName,
      'cnpj': cnpj,
      'state': state,
      'city': city,
      'zip_code': zipCode,
      'street': street,
      'number': number,
      'neighborhood': neighborhood,
      'complement': complement,
      'latitude': latitude,
      'longitude': longitude,
      'image_path': imagePath,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      legalName: map['legal_name'] as String?,
      cnpj: map['cnpj'] as String,
      state: map['state'] as String,
      city: map['city'] as String,
      zipCode: map['zip_code'] as String,
      street: map['street'] as String,
      number: map['number'] as String,
      neighborhood: map['neighborhood'] as String?,
      complement: map['complement'] as String?,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      imagePath: map['image_path'] as String?,
    );
  }

  factory ProfileModel.fromEntity(Profile profile) {
    return ProfileModel(
      id: profile.id,
      name: profile.name,
      legalName: profile.legalName,
      cnpj: profile.cnpj,
      state: profile.state,
      city: profile.city,
      zipCode: profile.zipCode,
      street: profile.street,
      number: profile.number,
      neighborhood: profile.neighborhood,
      complement: profile.complement,
      latitude: profile.latitude,
      longitude: profile.longitude,
      imagePath: profile.imagePath,
    );
  }
}
