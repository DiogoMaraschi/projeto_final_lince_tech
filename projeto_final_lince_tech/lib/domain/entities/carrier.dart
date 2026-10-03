import 'address.dart';

class Carrier {
  final int? id;
  final String name;
  final String? legalName;
  final String? cnpj;
  final String? email;
  final String? phoneNumber;
  final double costPerKm;
  final double minimumPrice;
  final int? addressId;
  final Address? address;

  Carrier({
    this.id,
    required this.name,
    this.legalName,
    this.cnpj,
    this.email,
    this.phoneNumber,
    required this.costPerKm,
    required this.minimumPrice,
    this.addressId,
    this.address,
  });

  Carrier copyWith({
    int? id,
    String? name,
    String? legalName,
    String? cnpj,
    String? email,
    String? phoneNumber,
    double? costPerKm,
    double? minimumPrice,
    int? addressId,
    Address? address,
  }) {
    return Carrier(
      id: id ?? this.id,
      name: name ?? this.name,
      legalName: legalName ?? this.legalName,
      cnpj: cnpj ?? this.cnpj,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      costPerKm: costPerKm ?? this.costPerKm,
      minimumPrice: minimumPrice ?? this.minimumPrice,
      addressId: addressId ?? this.addressId,
      address: address ?? this.address,
    );
  }
}
