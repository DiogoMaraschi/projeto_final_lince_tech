import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../entities/customer/costumer.dart';
import '../../entities/customer/establishment_type.dart';
import '../../l10n/app_localizations.dart';
import '../../main.dart';
import '../../modules/customer/customer_failure.dart';
import '../app_theme.dart';
import '../controllers/customer/customer_controller.dart';
import '../formatters/input_formatters.dart';
import '../validators/cnpj_validator.dart';
import '../validators/email_validator.dart';
import '../validators/not_empty_validator.dart';
import '../validators/not_selected_validator.dart';
import '../validators/phone_validator.dart';
import '../widgets/address_form.dart';
import '../widgets/bottom_button.dart';
import '../widgets/delete_button.dart';
import '../widgets/error_dialog.dart';
import '../widgets/labeled_text_form_field.dart';

class CustomerDetailsPage extends StatelessWidget {
  const CustomerDetailsPage({super.key, this._customer});

  final Customer? _customer;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomerController(
        getAddressByZipcodeUsecase: injection.getAddressByZipcodeUsecase,
        getCnpjUsecase: injection.getCnpjUsecase,
        createCustomerUsecase: injection.createCustomerUsecase,
        updateCustomerUsecase: injection.updateCustomerUsecase,
        deleteCustomerUsecase: injection.deleteCustomerUsecase,
        getLocationByAddressUsecase: injection.getLocationByAddressUsecase,
        customer: _customer,
      ),
      child: _CostumerDetailsPage(),
    );
  }
}

class _CostumerDetailsPage extends StatelessWidget {
  _CostumerDetailsPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _zipcodeFieldKey = GlobalKey<FormFieldState>();

  final cnpjFormatter = InputFormatters.cnpj();
  final phoneFormatter = InputFormatters.phone();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Consumer<CustomerController>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              l10n.customerTitle,
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
                        LabeledTextFormField(
                          label: l10n.commomCnpj,
                          controller: state.cnpjController,
                          hintText: l10n.commomCnpj,
                          keyboardType: TextInputType.number,
                          validator: (value) => validateCnpj(value, l10n),
                          inputFormatters: [cnpjFormatter],
                          suffixIcon: IconButton(
                            onPressed: state.searchCnpj,
                            icon: const Icon(Icons.search, size: 30),
                          ),
                        ),

                        const SizedBox(height: 16),

                        LabeledTextFormField(
                          label: l10n.customerName,
                          controller: state.nameController,
                          hintText: l10n.customerHintName,
                          validator: (value) => isNotEmpty(value, l10n),
                        ),

                        const SizedBox(height: 16),

                        LabeledTextFormField(
                          label: l10n.customerLegalName,
                          controller: state.legalNameController,
                          hintText: l10n.customerHintLegalName,
                          validator: (value) => isNotEmpty(value, l10n),
                        ),

                        const SizedBox(height: 16),

                        // Email
                        LabeledTextFormField(
                          label: l10n.commomEmail,
                          controller: state.emailController,
                          hintText: l10n.commomHintEmail,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => validateEmail(value, l10n),
                        ),

                        const SizedBox(height: 16),

                        // Phone
                        LabeledTextFormField(
                          label: l10n.commomPhone,
                          controller: state.phoneController,
                          hintText: l10n.commomHintPhone,
                          keyboardType: TextInputType.phone,
                          validator: (value) => validatePhone(value, l10n),
                          inputFormatters: [phoneFormatter],
                        ),

                        const SizedBox(height: 16),

                        Text(
                          l10n.establishmentType,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.labelColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 6),

                        SizedBox(
                          width: 280,
                          height: 70,
                          child: DropdownButtonFormField<EstablishmentType>(
                            initialValue: state.establishmentType,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppTheme.primaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                            hint: Text(l10n.customerChooseOption),
                            icon: const Icon(
                              Icons.arrow_downward_sharp,
                              color: AppTheme.primaryColor,
                            ),
                            elevation: 1,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            items: [
                              for (final value in EstablishmentType.values)
                                DropdownMenuItem(
                                  value: value,
                                  child: Text(value.translate(context)),
                                ),
                            ],
                            validator: (value) => isNotSelected(value, l10n),
                            onChanged: state.setEstablishmentType,
                          ),
                        ),

                        AddressForm(
                          zipcodeController: state.zipcodeController,
                          stateController: state.stateController,
                          cityController: state.cityController,
                          streetController: state.streetController,
                          numberController: state.numberController,
                          neighborhoodController: state.neighborhoodController,
                          complementController: state.complementController,
                          searchByZipcode: state.searchZipcode,
                          zipcodeFieldKey: _zipcodeFieldKey,
                        ),

                        SizedBox(height: 50),
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
                  final saved = await state.saveCustomer();

                  if (!context.mounted) return;

                  if (saved) {
                    Navigator.pop(context);
                  } else {
                    final message = switch (state.error) {
                      CustomerFailure.saveFailed => l10n.customerSaveFailed,
                      CustomerFailure.cnpjAlreadyRegistered =>
                        l10n.cnpjAlreadyRegistered,
                      CustomerFailure.locationNotObtained =>
                        l10n.locationNotObtained,
                      CustomerFailure.customerNotFound => l10n.customerNotFound,
                      null => l10n.customerSaveFailed,
                    };

                    await showErrorDialog(context, message: message);
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
                          title: Text(l10n.customerDeleteConfirmationTitle),
                          content: Text(l10n.customerDeleteConfirmationMessage),
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
