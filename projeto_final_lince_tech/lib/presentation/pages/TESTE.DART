import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart'; // adicione ao pubspec.yaml

class CadastroProdutoPage extends StatefulWidget {
  const CadastroProdutoPage({super.key});

  @override
  State<CadastroProdutoPage> createState() => _CadastroProdutoPageState();
}

class _CadastroProdutoPageState extends State<CadastroProdutoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _codigoBarrasController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _marcaController = TextEditingController();
  File? _imagemSelecionada;

  final Color _primaryColor = const Color(0xFF4F46E5);
  final Color _backgroundColor = const Color(0xFFFAFAFC);
  final Color _hintColor = const Color(0xFFA1A1AA);
  final Color _labelColor = const Color(0xFF52525B);

  Future<void> _selecionarImagem() async {
    final picker = ImagePicker();
    final imagem = await picker.pickImage(source: ImageSource.gallery);
    if (imagem != null) {
      setState(() {
        _imagemSelecionada = File(imagem.path);
      });
    }
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      // Lógica de salvar o produto
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produto salvo com sucesso!')),
      );
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _codigoBarrasController.dispose();
    _descricaoController.dispose();
    _marcaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF181818)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Cadastro de Produto',
          style: TextStyle(
            color: Color(0xFF181818),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF181818)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Seção de Imagem
                    Center(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: _selecionarImagem,
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF2F6),
                                shape: BoxShape.circle,
                              ),
                              child: _imagemSelecionada != null
                                  ? ClipOval(
                                      child: Image.file(
                                        _imagemSelecionada!,
                                        width: 110,
                                        height: 110,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Icon(
                                      Icons.camera_alt_outlined,
                                      size: 32,
                                      color: _primaryColor,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: _selecionarImagem,
                            child: Text(
                              'Adicionar Imagem',
                              style: TextStyle(
                                fontSize: 14,
                                color: _primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Campo: Nome do Produto
                    _buildLabel('Nome do Produto', isPrimary: true),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _nomeController,
                      hintText: 'Ex: Café Torrado Gourmet 500g',
                    ),
                    const SizedBox(height: 16),

                    // Campo: Código de Barras
                    _buildLabel('Código de Barras'),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _codigoBarrasController,
                      hintText: '7891000123456',
                      keyboardType: TextInputType.number,
                      suffixIcon: Icon(
                        Icons.qr_code_scanner,
                        color: _labelColor,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Campo: Descrição
                    _buildLabel('Descrição'),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _descricaoController,
                      hintText:
                          'Descreva detalhes do produto, como especificações, ingredientes ou notas de sabor...',
                      maxLines: 4,
                    ),
                    const SizedBox(height: 16),

                    // Campo: Marca
                    _buildLabel('Marca'),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _marcaController,
                      hintText: 'Ex: Fazenda Aliança',
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Botão Salvar fixo na parte inferior
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Salvar'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, {bool isPrimary = false}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: isPrimary ? _primaryColor : _labelColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E4E7), width: 1),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            color: _hintColor,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: InputBorder.none,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
