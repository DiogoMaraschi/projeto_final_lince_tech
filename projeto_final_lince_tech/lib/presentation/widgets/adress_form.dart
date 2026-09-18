import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../l10n/app_localizations.dart';
import '../validators/cep_validator.dart';
import '../validators/not_empty_validator.dart';
import 'commom_label.dart';
import 'commom_text_form_field.dart';

class AdressForm extends StatelessWidget {
  final TextEditingController cepController;
  final TextEditingController stateController;
  final TextEditingController cityController;
  final TextEditingController streetController;
  final TextEditingController numberController;
  final TextEditingController neighborhoodController;
  final TextEditingController complementController;
  final VoidCallback searchByZipcode;
  final GlobalKey<FormFieldState> cepFieldKey;

  const AdressForm({
    super.key,
    required this.cepController,
    required this.stateController,
    required this.cityController,
    required this.streetController,
    required this.numberController,
    required this.neighborhoodController,
    required this.complementController,
    required this.searchByZipcode,
    required this.cepFieldKey,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),

        // ADRESS
        CommomLabel(text: l10n.addressTitle, isPrimary: true),

        const SizedBox(height: 16),

        // ZIP CODE
        CommomLabel(text: l10n.addressCep, isPrimary: true),
        const SizedBox(height: 6),

        CommomTextFormField(
          key: cepFieldKey,
          controller: cepController,
          hintText: l10n.addressHintCep,
          keyboardType: TextInputType.number,
          validator: validateCep,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          suffixIcon: IconButton(
            onPressed: () {
              if (cepFieldKey.currentState!.validate()) {
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
                  CommomLabel(text: l10n.addressState, isPrimary: true),
                  const SizedBox(height: 6),

                  CommomTextFormField(
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
                  CommomLabel(text: l10n.addressCity, isPrimary: true),
                  const SizedBox(height: 6),

                  CommomTextFormField(
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
        CommomLabel(text: l10n.addressStreet, isPrimary: true),
        const SizedBox(height: 6),

        CommomTextFormField(
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
                  CommomLabel(text: l10n.addressNumber, isPrimary: true),
                  const SizedBox(height: 6),

                  CommomTextFormField(
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
                  CommomLabel(text: l10n.addressNeighborhood, isPrimary: true),
                  const SizedBox(height: 6),

                  CommomTextFormField(
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
        CommomLabel(text: l10n.addressComplement),
        const SizedBox(height: 6),

        CommomTextFormField(
          controller: complementController,
          hintText: l10n.addressHintComplement,
        ),
      ],
    );
  }
}
