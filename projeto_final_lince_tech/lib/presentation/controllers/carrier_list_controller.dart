import 'package:flutter/material.dart';

import '../../domain/entities/carrier.dart';

class CarrierListController with ChangeNotifier {
  //TODO usecases

  List<Carrier> _carriers = [];

  List<Carrier> get carriers => List.unmodifiable(_carriers);
}
