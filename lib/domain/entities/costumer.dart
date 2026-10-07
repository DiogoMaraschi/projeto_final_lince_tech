import 'package:flutter/cupertino.dart';

import '../../l10n/app_localizations.dart';

class Customer {
  final int? id;
  final String name;
  final String cnpj;
  final String legalName;
  final String? phoneNumber;
  final String? email;
  final EstablishmentType establishmentType;
  final String state;
  final String city;
  final String zipCode;
  final String street;
  final String number;
  final double latitude;
  final double longitude;

  Customer({
    this.id,
    required this.name,
    required this.cnpj,
    required this.legalName,
    this.phoneNumber,
    this.email,
    required this.establishmentType,
    required this.state,
    required this.city,
    required this.zipCode,
    required this.street,
    required this.number,
    required this.latitude,
    required this.longitude,
  });

  Customer copyWith({
    int? id,
    String? name,
    String? cnpj,
    String? legalName,
    String? phoneNumber,
    String? email,
    EstablishmentType? establishmentType,
    String? state,
    String? city,
    String? zipCode,
    String? street,
    String? number,
    double? latitude,
    double? longitude,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      cnpj: cnpj ?? this.cnpj,
      legalName: legalName ?? this.legalName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      establishmentType: establishmentType ?? this.establishmentType,
      state: state ?? this.state,
      city: city ?? this.city,
      zipCode: zipCode ?? this.zipCode,
      street: street ?? this.street,
      number: number ?? this.number,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

enum EstablishmentType {
  academia,
  escola,
  outro;

  String translate(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return switch (this) {
      academia => l10n!.costumerCategoryGym,
      escola => l10n!.costumerCategorySchool,
      outro => l10n!.costumerCategoryOther,
    };
  }

  String get databaseValue {
    return switch (this) {
      EstablishmentType.academia => 'academia',
      EstablishmentType.escola => 'escola',
      EstablishmentType.outro => 'outro',
    };
  }

  static EstablishmentType fromDatabaseValue(String value) {
    return switch (value) {
      'academia' => EstablishmentType.academia,
      'escola' => EstablishmentType.escola,
      'outro' => EstablishmentType.outro,
      _ => throw ArgumentError('Tipo de estabelecimento inválido: $value'),
    };
  }
}
