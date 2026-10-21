import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../main.dart';
import '../app_colors.dart';
import '../controllers/profile_details_controller.dart';
import '../formatters/app_formatters.dart';
import '../validators/cnpj_validator.dart';
import '../validators/not_empty_validator.dart';
import '../widgets/address_form.dart';
import '../widgets/bottom_button.dart';
import '../widgets/labeled_text_form_field.dart';

class ProfileDetailsPage extends StatelessWidget {
  ProfileDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileDetailsController(
        getAddressByZipcodeUsecase: injection.getAddressByZipcodeUsecase,
        getCnpjUsecase: injection.getCnpjUsecase,
        pickImageFromGaleryUsecase: injection.pickImageFromGaleryUsecase,
        getLocationByAddressUsecase: injection.getLocationByAddressUsecase,
        createProfileUsecase: injection.createProfileUsecase,
        updateProfileUsecase: injection.updateProfileUsecase,
        getProfileUsecase: injection.getProfileUsecase,
      )..getProfile(),
      child: _ProfileDetailsPage(),
    );
  }
}

class _ProfileDetailsPage extends StatelessWidget {
  _ProfileDetailsPage();

  final _formKey = GlobalKey<FormState>();
  final _zipcodeFieldKey = GlobalKey<FormFieldState>();

  final cnpjFormatter = AppFormatters.cnpj();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Consumer<ProfileDetailsController>(
      builder: (context, state, child) {
        final colors = Theme.of(context).colorScheme;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              l10n.storeTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: colors.primary,
              ),
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new),
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
                              Center(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: state.pickImageFromGalery,
                                      child: Container(
                                        width: 140,
                                        height: 140,
                                        decoration: BoxDecoration(
                                          color: colors.surfaceContainer,
                                          shape: BoxShape.circle,
                                        ),
                                        child: state.imagePath != null
                                            ? ClipOval(
                                                child: Image.file(
                                                  File(state.imagePath!),
                                                  width: 140,
                                                  height: 140,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : Icon(
                                                Icons.camera_alt_outlined,
                                                size: 32,
                                                color: AppColors.primaryColor,
                                              ),
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    GestureDetector(
                                      onTap: state.pickImageFromGalery,
                                      child: Text(
                                        l10n.commomAddImage,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 30),

                              LabeledTextFormField(
                                label: l10n.commomCnpj,
                                controller: state.cnpjController,
                                hintText: l10n.commomHintCnpj,
                                keyboardType: TextInputType.number,
                                validator: validateCnpj,
                                inputFormatters: [cnpjFormatter],
                                suffixIcon: IconButton(
                                  onPressed: state.searchCnpj,
                                  icon: const Icon(Icons.search, size: 30),
                                ),
                              ),

                              const SizedBox(height: 16),

                              LabeledTextFormField(
                                label: l10n.storeCompanyName,
                                controller: state.nameController,
                                hintText: l10n.storeHintCompanyName,
                                validator: isNotEmpty,
                              ),

                              const SizedBox(height: 16),

                              LabeledTextFormField(
                                label: l10n.carrierLegalName,
                                controller: state.legalNameController,
                                hintText: l10n.carrierHintLegalName,
                                validator: isNotEmpty,
                              ),

                              const SizedBox(height: 6),

                              AddressForm(
                                zipcodeController: state.zipcodeController,
                                stateController: state.stateController,
                                cityController: state.cityController,
                                streetController: state.streetController,
                                numberController: state.numberController,
                                neighborhoodController:
                                    state.neighborhoodController,
                                complementController:
                                    state.complementController,
                                searchByZipcode: state.searchZipcode,
                                zipcodeFieldKey: _zipcodeFieldKey,
                              ),

                              SizedBox(height: 30),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                clipBehavior: Clip.antiAlias,
                                height: 400,
                                child: GoogleMap(
                                  onMapCreated: (controller) {
                                    state.setController(controller);
                                  },
                                  initialCameraPosition: CameraPosition(
                                    target: state.location != null
                                        ? state.location!
                                        : state.defaultPosition,
                                    zoom: 18,
                                  ),
                                  markers: {
                                    Marker(
                                      markerId: MarkerId('teste'),
                                      position: state.location != null
                                          ? state.location!
                                          : state.defaultPosition,
                                      infoWindow: InfoWindow(
                                        title: 'Local de teste',
                                      ),
                                    ),
                                  },
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          bottomNavigationBar: BottomButton(
            btnText: l10n.commonSave,
            btnAction: () async {
              if (!_formKey.currentState!.validate()) return;

              final saved = await state.saveProfile();
              if (!context.mounted) return;

              if (saved) {
                Navigator.pop(context, true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Não foi possível salvar o perfil.'),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
