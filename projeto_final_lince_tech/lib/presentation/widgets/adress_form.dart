import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'commom_label.dart';
import 'commom_text_field.dart';

class AdressForm extends StatelessWidget {
  final TextEditingController cepController;
  final TextEditingController stateController;
  final TextEditingController cityController;
  final TextEditingController streetController;
  final TextEditingController numberController;
  final TextEditingController neighborhoodController;
  final TextEditingController complementController;
  final VoidCallback searchByZipcode;

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

        CommomTextField(
          controller: cepController,
          hintText: l10n.addressHintCep,
          keyboardType: TextInputType.number,
          suffixIcon: IconButton(
            onPressed: () {
              print('botao form');
              searchByZipcode();
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

                  CommomTextField(
                    controller: stateController,
                    hintText: l10n.addressHintState,
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

                  CommomTextField(
                    controller: cityController,
                    hintText: l10n.addressHintCity,
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

        CommomTextField(
          controller: streetController,
          hintText: l10n.addressHintStreet,
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

                  CommomTextField(
                    controller: numberController,
                    hintText: l10n.addressHintNumber,
                    keyboardType: TextInputType.number,
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

                  CommomTextField(
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

        CommomTextField(
          controller: complementController,
          hintText: l10n.addressHintComplement,
        ),
      ],
    );
  }
}
