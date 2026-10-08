class CnpjModel {
  final String cnpj;
  final String razaoSocial;
  final String nomeFantasia;
  final String? email;
  final String? telefone;

  final String? cep;
  final String? estado;
  final String? cidade;
  final String? rua;
  final String? numero;
  final String? bairro;
  final String? complemento;

  CnpjModel({
    required this.cnpj,
    required this.razaoSocial,
    required this.nomeFantasia,
    this.email,
    this.telefone,
    this.cep,
    this.estado,
    this.cidade,
    this.rua,
    this.numero,
    this.bairro,
    this.complemento,
  });

  factory CnpjModel.fromMap(Map<String, dynamic> map) {
    return CnpjModel(
      cnpj: map['cnpj'] as String,
      razaoSocial: map['razao_social'] as String,
      nomeFantasia: map['nome_fantasia'] as String,
      email: map['email'] as String?,
      telefone: map['ddd_telefone_1'] as String?,
      cep: map['cep'] as String?,
      estado: map['uf'] as String?,
      cidade: map['municipio'] as String?,
      rua: map['logradouro'] as String?,
      numero: map['numero'] as String?,
      bairro: map['bairro'] as String?,
      complemento: map['complemento'] as String?,
    );
  }
}
