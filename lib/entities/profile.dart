class Profile {
  final int? id;
  final String name;
  final String? legalName;
  final String cnpj;
  final String state;
  final String city;
  final String zipCode;
  final String street;
  final String number;
  final String? neighborhood;
  final String? complement;
  final double latitude;
  final double longitude;
  final String? imagePath;

  Profile({
    this.id,
    required this.name,
    this.legalName,
    required this.cnpj,
    required this.state,
    required this.city,
    required this.zipCode,
    required this.street,
    required this.number,
    this.neighborhood,
    this.complement,
    required this.latitude,
    required this.longitude,
    this.imagePath,
  });
}
