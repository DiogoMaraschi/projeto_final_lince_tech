String? isNotSelected<T>(T? value) {
  if (value == null) {
    return 'Campo obrigatório';
  }
  return null;
}