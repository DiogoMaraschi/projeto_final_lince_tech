String digitsOnly(String valor) {
  return valor.replaceAll(RegExp(r'\D'), '');
}
