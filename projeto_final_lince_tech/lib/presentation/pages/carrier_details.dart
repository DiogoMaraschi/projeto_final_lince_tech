import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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

class CarrierDetailsPage extends StatelessWidget {
  const CarrierDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CarrierController(
        getCnpjUsecase: injection.getCnpjUsecase,
        createCarrierUsecase: injection.createCarrierUsecase,
      ),
      child: const _CarrierDetailState(),
    );
  }
}

class _CarrierDetailState extends StatelessWidget {
  const _CarrierDetailState();

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
                              CommomLabel(
                                text: l10n.commomCnpj,
                                isPrimary: true,
                              ),
                              const SizedBox(height: 6),
                              CommomTextFormField(
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
                              CommomLabel(text: l10n.carrierName),
                              const SizedBox(height: 6),
                              CommomTextFormField(
                                controller: state.nameController,
                                hintText: l10n.carrierHintName,
                                validator: isNotEmpty,
                              ),

                              const SizedBox(height: 16),

                              // Legal Name
                              CommomLabel(text: l10n.carrierLegalName),
                              const SizedBox(height: 6),
                              CommomTextFormField(
                                controller: state.legalNameController,
                                hintText: l10n.carrierHintLegalName,
                                validator: isNotEmpty,
                              ),

                              const SizedBox(height: 16),

                              // Email
                              CommomLabel(
                                text: l10n.commomEmail,
                                isPrimary: true,
                              ),
                              const SizedBox(height: 6),
                              CommomTextFormField(
                                controller: state.emailController,
                                hintText: l10n.commomHintEmail,
                                keyboardType: TextInputType.emailAddress,
                                validator: validateEmail,
                              ),

                              const SizedBox(height: 16),

                              // Phone
                              CommomLabel(
                                text: l10n.commomPhone,
                                isPrimary: true,
                              ),
                              const SizedBox(height: 6),
                              CommomTextFormField(
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
                                        CommomLabel(
                                          text: l10n.carrierCostPerKm,
                                          isPrimary: true,
                                        ),
                                        const SizedBox(height: 6),
                                        CommomTextFormField(
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
                                        CommomLabel(
                                          text: l10n.carrierMinimumPrice,
                                          isPrimary: true,
                                        ),
                                        const SizedBox(height: 6),
                                        CommomTextFormField(
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
          bottomNavigationBar: BottomButton(
            btnText: 'Salvar',
            btnAction: () async {
              if (!_formKey.currentState!.validate()) {
                return;
              }

              await state.saveCarrier();

              if (!context.mounted) return;

              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
