import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../entities/customer.dart';
import '../../l10n/app_localizations.dart';
import '../../main.dart';
import '../app_colors.dart';
import '../controllers/customer_controller.dart';
import '../extensions/establishment_type_localization.dart';
import '../validators/cnpj_validator.dart';
import '../validators/email_validator.dart';
import '../validators/not_empty_validator.dart';
import '../validators/not_selected_validator.dart';
import '../validators/phone_validator.dart';
import '../widgets/address_form.dart';
import '../widgets/bottom_button.dart';
import '../widgets/commom_label.dart';
import '../widgets/commom_text_form_field.dart';
import '../widgets/delete_button.dart';

class CostumerDetailsPage extends StatelessWidget {
  const CostumerDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomerController(
        getAddressByZipcodeUsecase: injection.getAddressByZipcodeUsecase,
        getCnpjUsecase: injection.getCnpjUsecase,
        createCustomerUsecase: injection.createCustomerUsecase,
        getAllCustomersUsecase: injection.getAllCustomersUsecase,
      ),
      child: _CostumerDetailsPage(),
    );
  }
}

class _CostumerDetailsPage extends StatelessWidget {
  _CostumerDetailsPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _zipcodeFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Consumer<CustomerController>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Clientes',
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
                        CommomLabel(text: l10n.commomCnpj),

                        const SizedBox(height: 6),

                        CommomTextFormField(
                          controller: state.cnpjController,
                          hintText: l10n.commomCnpj,
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

                        CommomLabel(text: l10n.carrierName),
                        const SizedBox(height: 6),
                        CommomTextFormField(
                          controller: state.nameController,
                          hintText: l10n.carrierHintName,
                          validator: isNotEmpty,
                        ),

                        const SizedBox(height: 16),

                        CommomLabel(text: l10n.carrierLegalName),
                        const SizedBox(height: 6),
                        CommomTextFormField(
                          controller: state.legalNameController,
                          hintText: l10n.carrierHintLegalName,
                          validator: isNotEmpty,
                        ),

                        const SizedBox(height: 16),

                        // Email
                        CommomLabel(text: l10n.commomEmail, isPrimary: true),
                        const SizedBox(height: 6),
                        CommomTextFormField(
                          controller: state.emailController,
                          hintText: l10n.commomHintEmail,
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmail,
                        ),

                        const SizedBox(height: 16),

                        // Phone
                        CommomLabel(text: l10n.commomPhone, isPrimary: true),
                        const SizedBox(height: 6),
                        CommomTextFormField(
                          controller: state.phoneController,
                          hintText: l10n.commomHintPhone,
                          keyboardType: TextInputType.phone,
                          validator: validatePhone,
                        ),

                        const SizedBox(height: 16),

                        CommomLabel(
                          text: 'Tipo de Estabelecimento',
                          isPrimary: true,
                        ),

                        const SizedBox(height: 6),

                        SizedBox(
                          width: 280,
                          height: 70,
                          child: DropdownButtonFormField<EstablishmentType>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),

                              // focusedBorder: b,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                            hint: Text('Escolha uma opção'),
                            icon: const Icon(
                              Icons.arrow_downward_sharp,
                              color: AppColors.primaryColor,
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
                            validator: isNotSelected,
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
                btnText: state.isLoading ? 'Editar' : 'Salvar',
                btnAction: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  await state.saveCostumer();
                  print('clicou');

                  if (!context.mounted) return;

                  //  Navigator.pop(context);
                },
              ),
              if (state.isLoading)
                DeleteButton(
                  btnText: 'Excluir',
                  btnAction: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) {
                        return AlertDialog(
                          title: const Text('Excluir cliente?'),
                          content: const Text(
                            'O cliente não será exibido na lista, mas seus dados serão mantidos.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext, false);
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext, true);
                              },
                              child: const Text('Excluir'),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm != true) return;

                    // final success = await state.delete();

                    if (!context.mounted) return;

                    // if (success) {
                    //   Navigator.pop(context);
                    // }
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
