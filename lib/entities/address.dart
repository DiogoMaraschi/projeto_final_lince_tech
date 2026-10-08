/// Address data returned by a postal-code lookup.
///
/// This is a reusable value object, not a separately persisted database entity.
class Address {
  final String zipCode;
  final String street;
  final String? neighborhood;
  final String? complement;
  final String city;
  final String state;

  const Address({
    required this.zipCode,
    required this.street,
    this.neighborhood,
    this.complement,
    required this.city,
    required this.state,
  });
}
