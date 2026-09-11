class Carrier {
  final int? id;
  final String name;
  final String? legalName;
  final String? cnpj;
  final String? email;
  final String? phoneNumber;
  final double costPerKm;
  final double minimunPrice;
  final int adressId;

  Carrier({
    this.id,
    required this.name,
    this.legalName,
    this.cnpj,
    this.email,
    this.phoneNumber,
    required this.costPerKm,
    required this.minimunPrice,
    required this.adressId,
  });
}
