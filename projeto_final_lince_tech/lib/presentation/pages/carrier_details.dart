import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../main.dart';
import '../controllers/carrier_controller.dart';
import '../widgets/adress_form.dart';
import '../widgets/commom_label.dart';
import '../widgets/commom_text_field.dart';

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CNPJ
                        CommomLabel(text: l10n.commomCnpj, isPrimary: true),
                        SizedBox(height: 6),
                        CommomTextField(
                          controller: state.cnpjController,
                          hintText: l10n.commomHintCnpj,
                          keyboardType: TextInputType.number,
                          suffixIcon: IconButton(
                            onPressed: () {
                              context.read<CarrierController>().searchCnpj();
                              print('botao pressionado');
                            },
                            icon: const Icon(Icons.search, size: 30),
                          ),
                        ),

                        SizedBox(height: 16),
                        // Name
                        CommomLabel(text: l10n.carrierName),
                        SizedBox(height: 6),
                        CommomTextField(
                          controller: state.nameController,
                          hintText: l10n.carrierHintName,
                        ),

                        SizedBox(height: 16),

                        // Legal Name
                        CommomLabel(text: l10n.carrierLegalName),
                        SizedBox(height: 6),
                        CommomTextField(
                          controller: state.legalNameController,
                          hintText: l10n.carrierHintLegalName,
                        ),

                        SizedBox(height: 16),

                        // Email
                        CommomLabel(text: l10n.commomEmail, isPrimary: true),
                        SizedBox(height: 6),
                        CommomTextField(
                          controller: state.emailController,
                          hintText: l10n.commomHintEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 16),

                        // Phone
                        CommomLabel(text: l10n.commomPhone, isPrimary: true),
                        SizedBox(height: 6),
                        CommomTextField(
                          controller: state.phoneController,
                          hintText: l10n.commomHintPhone,
                          keyboardType: TextInputType.phone,
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
                                  CommomTextField(
                                    controller: state.costPerKmController,
                                    hintText: l10n.carrierHintCostPerKm,
                                    keyboardType: TextInputType.number,
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
                                  CommomTextField(
                                    controller: state.minimumPriceController,
                                    hintText: l10n.carrierHintMinimumPrice,
                                    keyboardType: TextInputType.phone,
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
    );
  }
}
