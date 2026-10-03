import 'package:flutter/cupertino.dart';

import '../../core/dependecies/injection.dart';
import '../../domain/usecases/adress/get_address_by_zipcode.dart';
import '../../l10n/app_localizations.dart';

class CostumerController with ChangeNotifier{
  CostumerController();


  final nameController = TextEditingController();
  final legalNameController = TextEditingController();
  final cnpjController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final zipcodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final complementController = TextEditingController();

  @override
  void dispose() {
    cnpjController.dispose();
    nameController.dispose();
    legalNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

Future<void> searchZipcode() async {
  try {
    final result = await Injection().getAllCarriersUsecase(zipcodeController.text);

    stateController.text = result.state;
    cityController.text = result.city;
    streetController.text = result.street;
    neighborhoodController.text = result.neighborhood ?? '';

    notifyListeners();
  } catch (e) {
    print(e);
  }
}

}

enum CostumerCategories{
  Academia,
  Escola,
  Outro;

  String translate(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return switch (this) {
      Academia => l10n!.costumerCategoryGym,
      Escola => l10n!.costumerCategorySchool,
      Outro => l10n!.costumerCategoryOther,
    };
  }
}

