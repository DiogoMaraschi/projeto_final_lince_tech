String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'E-mail é obrigatório';
  }

  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  if (!emailRegex.hasMatch(value)) {
    return 'E-mail inválido';
  }

  return null;
}
