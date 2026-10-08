String? validateCep(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'CEP é obrigatório';
  }

  final cep = value.replaceAll(RegExp(r'\D'), '');

  if (cep.length != 8) {
    return 'CEP inválido';
  }

  return null;
}
