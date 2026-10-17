import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../l10n/app_localizations.dart';
import '../app_colors.dart';
import '../formatters/app_formatters.dart';
import '../validators/cep_validator.dart';
import '../validators/not_empty_validator.dart';
import 'commom_label.dart';
import 'commom_text_form_field.dart';
import 'labeled_text_form_field.dart';

class AddressForm extends StatelessWidget {
  final TextEditingController zipcodeController;
  final TextEditingController stateController;
  final TextEditingController cityController;
  final TextEditingController streetController;
  final TextEditingController numberController;
  final TextEditingController neighborhoodController;
  final TextEditingController complementController;
  final VoidCallback searchByZipcode;
  final GlobalKey<FormFieldState> zipcodeFieldKey;

  AddressForm({
    super.key,
    required this.zipcodeController,
    required this.stateController,
    required this.cityController,
    required this.streetController,
    required this.numberController,
    required this.neighborhoodController,
    required this.complementController,
    required this.searchByZipcode,
    required this.zipcodeFieldKey,
  });

  final zipcodeFormatter = AppFormatters.zipcode();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),

        // ADRESS
        Text(
          'Address',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),

        const SizedBox(height: 16),

        // ZIP CODE
        LabeledTextFormField(
          label: l10n.addressCep,
          fieldKey: zipcodeFieldKey,
          controller: zipcodeController,
          hintText: l10n.addressHintCep,
          keyboardType: TextInputType.number,
          validator: validateCep,
          inputFormatters: [zipcodeFormatter],
          suffixIcon: IconButton(
            onPressed: () {
              if (zipcodeFieldKey.currentState!.validate()) {
                searchByZipcode();
              }
            },
            icon: const Icon(Icons.search, size: 30),
          ),
        ),

        const SizedBox(height: 16),

        // STATE AND CITY
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabeledTextFormField(
                    label: l10n.addressState,
                    controller: stateController,
                    hintText: l10n.addressHintState,
                    validator: isNotEmpty,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 20),

            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabeledTextFormField(
                    label: l10n.addressCity,
                    controller: cityController,
                    hintText: l10n.addressHintCity,
                    validator: isNotEmpty,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // STREET
        LabeledTextFormField(
          label: l10n.addressStreet,
          controller: streetController,
          hintText: l10n.addressHintStreet,
          validator: isNotEmpty,
        ),

        const SizedBox(height: 16),

        // NUMBER AND NEIGHBORHOOD
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabeledTextFormField(
                    label: l10n.addressNumber,
                    controller: numberController,
                    hintText: l10n.addressHintNumber,
                    keyboardType: TextInputType.number,
                    validator: isNotEmpty,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 20),

            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabeledTextFormField(
                    label: l10n.addressNeighborhood,
                    controller: neighborhoodController,
                    hintText: l10n.addressHintNeighborhood,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // COMPLEMENT
        LabeledTextFormField(
          label: l10n.addressComplement,
          controller: complementController,
          hintText: l10n.addressHintComplement,
        ),
      ],
    );
  }
}
