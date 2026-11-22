import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../entities/product.dart';
import '../../l10n/app_localizations.dart';
import '../../main.dart';
import '../app_theme.dart';
import '../controllers/product/product_controller.dart';
import '../formatters/input_formatters.dart';
import '../validators/not_empty_validator.dart';
import '../validators/positive_money_validator.dart';
import '../widgets/bottom_button.dart';
import '../widgets/delete_button.dart';
import '../widgets/labeled_text_form_field.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, this.product});

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductController(
        createProductUsecase: injection.createProductUsecase,
        captureImageUsecase: injection.captureImageUsecase,
        updateProductUsecase: injection.updateProductUsecase,
        deleteProductUsecase: injection.deleteProductUsecase,
        pickImageFromGaleryUsecase: injection.pickImageFromGaleryUsecase,
        product: product,
      ),
      child: _ProductDetailsState(),
    );
  }
}

class _ProductDetailsState extends StatelessWidget {
  _ProductDetailsState();

  final _formKey = GlobalKey<FormState>();

  final primaryColor = AppTheme.primaryColor;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;

    return Consumer<ProductController>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              l10n.productTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new),
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
                                onTap: () async {
                                  await showImageSourceOptions(context, state);
                                },
                                child: Container(
                                  width: 110,
                                  height: 110,
                                  decoration:  BoxDecoration(
                                    color: colors.surfaceContainer,
                                    shape: BoxShape.circle,
                                  ),
                                  child: state.imagePath != null
                                      ? ClipOval(
                                          child: Image.file(
                                            File(state.imagePath!),
                                            width: 110,
                                            height: 110,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Icon(
                                          Icons.camera_alt_outlined,
                                          size: 32,
                                          color: primaryColor,
                                        ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              GestureDetector(
                                onTap: () async {
                                  await showImageSourceOptions(context, state);
                                },
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
                        LabeledTextFormField(
                          label: l10n.productName,
                          controller: state.nameController,
                          hintText: l10n.productHintName,
                          validator: (value) => isNotEmpty(value, l10n),
                          textCapitalization: TextCapitalization.words,
                        ),

                        const SizedBox(height: 16),

                        // Barcode
                        LabeledTextFormField(
                          label: l10n.productBarcode,
                          controller: state.barcodeController,
                          hintText: l10n.productHintBarcode,
                          keyboardType: TextInputType.number,
                          validator: (value) => isNotEmpty(value, l10n),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(14),
                          ],
                          suffixIcon: const Icon(
                            Icons.qr_code_scanner,
                            size: 28,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Description
                        LabeledTextFormField(
                          label: l10n.productDescription,
                          controller: state.descriptionController,
                          hintText: l10n.productHintDescription,
                          maxLines: 4,
                          textCapitalization: TextCapitalization.sentences,
                        ),

                        const SizedBox(height: 16),

                        // Brand
                        LabeledTextFormField(
                          label: l10n.productBrand,
                          controller: state.brandController,
                          hintText: l10n.productHintBrand,
                          validator: (value) => isNotEmpty(value, l10n),
                          textCapitalization: TextCapitalization.words,
                        ),

                        const SizedBox(height: 16),

                        LabeledTextFormField(
                          label: l10n.productPrice,
                          controller: state.salePriceController,
                          hintText: l10n.productHintPrice,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          validator: (value) =>
                              validatePositiveMoney(value, l10n),
                          inputFormatters: [InputFormatters.money()],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomButton(
                btnText: state.isEditing ? l10n.commonEdit : l10n.commonSave,
                btnAction: () async {
                  if (_formKey.currentState!.validate()) {
                    final success = await state.saveProduct();

                    if (!context.mounted) return;

                    if (success) {
                      Navigator.pop(context);
                    }
                  }
                },
              ),
              if (state.isEditing)
                DeleteButton(
                  btnText: l10n.commonDelete,
                  btnAction: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) {
                        return AlertDialog(
                          title: Text(l10n.productDeleteConfirmationTitle),
                          content: Text(l10n.productDeleteConfirmationMessage),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext, false);
                              },
                              child: Text(l10n.commonCancel),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext, true);
                              },
                              child: Text(l10n.commonDelete),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm != true) return;

                    final success = await state.delete();

                    if (!context.mounted) return;

                    if (success) {
                      Navigator.pop(context);
                    }
                  },
                ),
              SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }

  Future<void> showImageSourceOptions(
    BuildContext context,
    ProductController controller,
  ) async {

    final option = await showModalBottomSheet<_ImageSourceOption>(
      context: context,
      builder: (sheetContext) {
        final l10n = AppLocalizations.of(context)!;
        return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(l10n.imageSourceTakePhoto),
              onTap: () =>
                  Navigator.pop(sheetContext, _ImageSourceOption.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l10n.imageSourceChooseGallery),
              onTap: () =>
                  Navigator.pop(sheetContext, _ImageSourceOption.gallery),
            ),
          ],
        ),
      );
      },
    );

    if (!context.mounted || option == null) return;

    if (option == _ImageSourceOption.camera) {
      await controller.captureImage();
    } else {
      await controller.pickImageFromGalery();
    }
  }
}

enum _ImageSourceOption { camera, gallery }
