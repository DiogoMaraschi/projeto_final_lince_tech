class Adress {
  final int? id;
  final String zipCode;
  final String street;
  final int number;
  final String? neighborhood;
  final String? complement;
  final String city;
  final String state;
  final double? latitude;
  final double? longitude;

  Adress({
    this.id,
    required this.zipCode,
    required this.street,
    required this.number,
    this.neighborhood,
    this.complement,
    required this.city,
    required this.state,
    this.latitude,
    this.longitude,
  });
}
