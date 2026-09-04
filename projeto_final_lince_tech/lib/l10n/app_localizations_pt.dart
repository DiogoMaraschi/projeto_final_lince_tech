// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Gestão de Produtos';

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonBack => 'Voltar';

  @override
  String get productTitle => 'Cadastro de Produto';

  @override
  String get productName => 'Nome do Produto';

  @override
  String get productHintName => 'Ex: Bola de Futebol';

  @override
  String get productBarcode => 'Código de Barras';

  @override
  String get productHintBarcode => '984651654892318974';

  @override
  String get productDescription => 'Descrição';

  @override
  String get productHintDescription => 'Descreva detalhes do produto';

  @override
  String get productBrand => 'Marca';

  @override
  String get productHintBrand => 'Ex: Nike';

  @override
  String get productAddImage => 'Adicionar Imagem';

  @override
  String get customerTitle => 'Cadastro de Cliente';

  @override
  String get customerName => 'Nome';

  @override
  String get customerCnpj => 'CNPJ';

  @override
  String get customerPhone => 'Telefone';

  @override
  String get customerEmail => 'E-mail';

  @override
  String get orderTitle => 'Pedido';

  @override
  String get orderNumber => 'Número do Pedido';

  @override
  String get orderPaymentMethod => 'Forma de Pagamento';

  @override
  String get orderInstallments => 'Parcelas';

  @override
  String get orderTotal => 'Total';
}
