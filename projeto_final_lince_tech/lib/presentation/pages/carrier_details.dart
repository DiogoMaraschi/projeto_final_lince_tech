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
import '../widgets/adress_form.dart';
import '../widgets/bottom_button.dart';
import '../widgets/commom_label.dart';
import '../widgets/commom_text_form_field.dart';

class CarrierDetails extends StatelessWidget {
  const CarrierDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CarrierController(
        getCnpjUsecase: injection.getCnpjUsecase,
        getAdressUsecase: injection.getAdressUsecase,
      ),
      child: _CarrierDetailState(),
    );
  }
}

class _CarrierDetailState extends StatelessWidget {
  _CarrierDetailState();

  final _formKey = GlobalKey<FormState>();
  final _cepFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n!.carrierTitle,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Consumer<CarrierController>(
        builder: (context, state, child) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(18),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CNPJ
                        CommomLabel(text: l10n.commomCnpj, isPrimary: true),
                        SizedBox(height: 6),
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

                        SizedBox(height: 16),
                        // Name
                        CommomLabel(text: l10n.carrierName),
                        SizedBox(height: 6),
                        CommomTextFormField(
                          controller: state.nameController,
                          hintText: l10n.carrierHintName,
                          validator: isNotEmpty,
                        ),

                        SizedBox(height: 16),

                        // Legal Name
                        CommomLabel(text: l10n.carrierLegalName),
                        SizedBox(height: 6),
                        CommomTextFormField(
                          controller: state.legalNameController,
                          hintText: l10n.carrierHintLegalName,
                          validator: isNotEmpty,
                        ),

                        SizedBox(height: 16),

                        // Email
                        CommomLabel(text: l10n.commomEmail, isPrimary: true),
                        SizedBox(height: 6),
                        CommomTextFormField(
                          controller: state.emailController,
                          hintText: l10n.commomHintEmail,
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmail,
                        ),

                        SizedBox(height: 16),

                        // Phone
                        CommomLabel(text: l10n.commomPhone, isPrimary: true),
                        SizedBox(height: 6),
                        CommomTextFormField(
                          controller: state.phoneController,
                          hintText: l10n.commomHintPhone,
                          keyboardType: TextInputType.phone,
                          validator: validatePhone,
                        ),

                        SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Cost Per Km
                                  CommomLabel(
                                    text: l10n.carrierCostPerKm,
                                    isPrimary: true,
                                  ),
                                  SizedBox(height: 6),
                                  CommomTextFormField(
                                    controller: state.costPerKmController,
                                    hintText: l10n.carrierHintCostPerKm,
                                    keyboardType: TextInputType.number,
                                    validator: isNotEmpty,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Minimum Price
                                  CommomLabel(
                                    text: l10n.carrierMinimumPrice,
                                    isPrimary: true,
                                  ),
                                  SizedBox(height: 6),
                                  CommomTextFormField(
                                    controller: state.minimumPriceController,
                                    hintText: l10n.carrierHintMinimumPrice,
                                    keyboardType: TextInputType.phone,
                                    validator: isNotEmpty,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        AdressForm(
                          cepController: state.zipcodeController,
                          stateController: state.stateController,
                          cityController: state.cityController,
                          streetController: state.streetController,
                          numberController: state.numberController,
                          neighborhoodController: state.neighborhoodController,
                          complementController: state.complementController,
                          searchByZipcode: state.searchZipcode,
                          cepFieldKey: _cepFieldKey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
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
  }
}
