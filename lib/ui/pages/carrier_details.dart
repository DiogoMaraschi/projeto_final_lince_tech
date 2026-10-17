import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../entities/carrier.dart';
import '../../l10n/app_localizations.dart';
import '../../main.dart';
import '../controllers/carrier_controller.dart';
import '../validators/cnpj_validator.dart';
import '../validators/email_validator.dart';
import '../validators/not_empty_validator.dart';
import '../validators/phone_validator.dart';
import '../widgets/bottom_button.dart';
import '../widgets/commom_label.dart';
import '../widgets/commom_text_form_field.dart';
import '../widgets/delete_button.dart';
import '../widgets/labeled_text_form_field.dart';

class CarrierDetailsPage extends StatelessWidget {
  const CarrierDetailsPage({super.key, this.carrier});

  final Carrier? carrier;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CarrierController(
        getCnpjUsecase: injection.getCnpjUsecase,
        createCarrierUsecase: injection.createCarrierUsecase,
        updateCarrierUsecase: injection.updateCarrierUsecase,
        deleteCarrierUsecase: injection.deleteCarrierUsecase,
        carrier: carrier,
      ),
      child: const _CarrierDetailPage(),
    );
  }
}

class _CarrierDetailPage extends StatelessWidget {
  const _CarrierDetailPage();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final _formKey = GlobalKey<FormState>();

    return Consumer<CarrierController>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              l10n.carrierTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: state.isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(18),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // CNPJ
                              LabeledTextFormField(
                                label: l10n.commomCnpj,
                                controller: state.cnpjController,
                                hintText: l10n.commomHintCnpj,
                                keyboardType: TextInputType.number,
                                validator: validateCnpj,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                suffixIcon: IconButton(
                                  onPressed: state.searchCnpj,
                                  icon: const Icon(Icons.search, size: 30),
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Name
                              LabeledTextFormField(
                                label: l10n.carrierName,
                                controller: state.nameController,
                                hintText: l10n.carrierHintName,
                                validator: isNotEmpty,
                              ),

                              const SizedBox(height: 16),

                              // Legal Name
                              LabeledTextFormField(
                                label: l10n.carrierLegalName,
                                controller: state.legalNameController,
                                hintText: l10n.carrierHintLegalName,
                                validator: isNotEmpty,
                              ),

                              const SizedBox(height: 16),

                               LabeledTextFormField(
                                label: l10n.commomEmail,
                                controller: state.emailController,
                                hintText: l10n.commomHintEmail,
                                keyboardType: TextInputType.emailAddress,
                                validator: validateEmail,
                              ),

                              const SizedBox(height: 16),

                              // Phone
                              LabeledTextFormField(
                                label: l10n.commomPhone,
                                controller: state.phoneController,
                                hintText: l10n.commomHintPhone,
                                keyboardType: TextInputType.phone,
                                validator: validatePhone,
                              ),

                              const SizedBox(height: 16),

                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LabeledTextFormField(
                                          label: l10n.carrierCostPerKm,
                                          controller: state.costPerKmController,
                                          hintText: l10n.carrierHintCostPerKm,
                                          keyboardType: TextInputType.number,
                                          validator: isNotEmpty,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LabeledTextFormField(
                                          label: l10n.carrierMinimumPrice,
                                          controller:
                                              state.minimumPriceController,
                                          hintText:
                                              l10n.carrierHintMinimumPrice,
                                          keyboardType: TextInputType.number,
                                          validator: isNotEmpty,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  await state.saveCarrier();

                  if (!context.mounted) return;

                  Navigator.pop(context);
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
                          title: Text(l10n.carrierDeleteConfirmationTitle),
                          content: Text(l10n.carrierDeleteConfirmationMessage),
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
            ],
          ),
        );
      },
    );
  }
}
