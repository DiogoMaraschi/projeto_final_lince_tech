String? validatePhone(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Telefone é obrigatório';
  }

  final phone = value.replaceAll(RegExp(r'\D'), '');

  if (phone.length != 10 && phone.length != 11) {
    return 'Telefone inválido';
  }

  return null;
}
