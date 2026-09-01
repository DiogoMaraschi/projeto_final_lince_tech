import 'dart:ui';

import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final Color primaryColor = Colors.deepPurpleAccent;
  final Color backgroundColor = Colors.white;
  final Color hintColor = Colors.grey;
  final Color labelColor = Colors.grey.shade600;

  final _nomeController = TextEditingController();
  final _codigoBarrasController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _marcaController = TextEditingController();

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
      appBar: AppBar(
        title: Text(
          'Cadastro de Produto',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => print('clicou na imagem'),
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF2F6),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 32,
                                color: primaryColor,
                              ),
                            ),
                          ),

                          SizedBox(height: 8),

                          GestureDetector(
                            onTap: () => print('clicou no texto'),
                            child: Text(
                              'Adicionar Imagem',
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

                    //Product Name
                    _buildLabel('Nome do Produto', isPrimary: true),
                    SizedBox(height: 6),
                    _buildTextField(
                      controller: _nomeController,
                      hintText: 'Ex: Bola de Futebol',
                    ),

                    SizedBox(height: 16),

                    //Barcode
                    _buildLabel('Código de Barras', isPrimary: true),
                    SizedBox(height: 6),
                    _buildTextField(
                      controller: _codigoBarrasController,
                      hintText: '98742346987945',
                      keyboardType: TextInputType.number,
                      suffixIcon: Icon(Icons.qr_code_scanner, size: 28),
                    ),

                    SizedBox(height: 16),

                    //Description
                    _buildLabel('Descrição', isPrimary: true),
                    SizedBox(height: 6),
                    _buildTextField(
                      controller: _descricaoController,
                      hintText: 'Descreva detalhes do produto',
                      maxLines: 4,
                    ),

                    SizedBox(height: 16),

                    //Brand
                    _buildLabel('Marca'),
                    SizedBox(height: 6),
                    _buildTextField(
                      controller: _marcaController,
                      hintText: 'Ex: Nike',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white),
            child: SizedBox(
              height: 54,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => print('clicou'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  textStyle: TextStyle(fontSize: 16, fontWeight: .w600),
                ),
                child: Text('Salvar'),
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
        fontSize: 16,
        color: isPrimary ? primaryColor : labelColor,
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
          hintStyle: TextStyle(fontSize: 16, color: hintColor),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: InputBorder.none,
          suffixIcon: suffixIcon,
          suffixIconColor: primaryColor,
        ),
      ),
    );
  }
}
