import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../main.dart';
import '../app_colors.dart';
import '../controllers/product_controller.dart';
import '../validators/not_empty_validator.dart';
import '../widgets/bottom_button.dart';
import '../widgets/commom_label.dart';
import '../widgets/commom_text_form_field.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductController(
        createProductUsecase: injection.createProductUsecase,
      ),
      child: _ProductDetailsState(),
    );
  }
}

class _ProductDetailsState extends StatelessWidget {
  _ProductDetailsState();

  final _formKey = GlobalKey<FormState>();

  final primaryColor = AppColors().primaryColor;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Consumer<ProductController>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              l10n!.productTitle,
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
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => state.takePicture(),
                                child: Container(
                                  width: 110,
                                  height: 110,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEEF2F6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 32,
                                    color: primaryColor,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              GestureDetector(
                                onTap: () => print('clicou no texto'),
                                child: Text(
                                  l10n.commomAddImage,
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

                        const SizedBox(height: 24),

                        // Product Name
                        CommomLabel(text: l10n.productName, isPrimary: true),

                        const SizedBox(height: 6),

                        CommomTextFormField(
                          controller: state.nameController,
                          hintText: l10n.productHintName,
                          validator: isNotEmpty,
                        ),

                        const SizedBox(height: 16),

                        // Barcode
                        CommomLabel(text: l10n.productBarcode, isPrimary: true),

                        const SizedBox(height: 6),

                        CommomTextFormField(
                          controller: state.barcodeController,
                          hintText: l10n.productHintBarcode,
                          keyboardType: TextInputType.number,
                          validator: isNotEmpty,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          suffixIcon: const Icon(
                            Icons.qr_code_scanner,
                            size: 28,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Description
                        CommomLabel(
                          text: l10n.productDescription,
                          isPrimary: true,
                        ),

                        const SizedBox(height: 6),

                        CommomTextFormField(
                          controller: state.descriptionController,
                          hintText: l10n.productHintDescription,
                          maxLines: 4,
                        ),

                        const SizedBox(height: 16),

                        // Brand
                        CommomLabel(text: l10n.productBrand),

                        const SizedBox(height: 6),

                        CommomTextFormField(
                          controller: state.brandController,
                          hintText: l10n.productHintBrand,
                          validator: isNotEmpty,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomButton(
            btnText: 'Salvar',
            btnAction: () {
              if (_formKey.currentState!.validate()) {
                print('Formulário válido');
                // TODO salvar no banco
              }
            },
          ),
        );
      },
    );
  }
}
