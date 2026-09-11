import 'package:flutter/material.dart';

import '../app_colors.dart';

class CommomLabel extends StatelessWidget {
  CommomLabel({super.key, this.isPrimary = false, required this.text});

  final bool isPrimary;
  final String text;

  final primaryColor = AppColors().primaryColor;
  final labelColor = AppColors().labelColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: isPrimary ? primaryColor : labelColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
