import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_colors.dart';

class CommomTextFormField extends StatelessWidget {
  CommomTextFormField({
    super.key,
    required this._controller,
    required this._hintText,
    this._keyboardType = TextInputType.text,
    this._maxLines = 1,
    this._suffixIcon,
    this.validator,
    this.inputFormatters,
    this.fieldKey,
  });

  final TextEditingController _controller;
  final String _hintText;
  final TextInputType _keyboardType;
  final int _maxLines;
  final Widget? _suffixIcon;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Key? fieldKey;

  final primaryColor = AppColors().primaryColor;
  final hintColor = AppColors().hintColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E4E7), width: 1),
      ),
      child: TextFormField(
        key: fieldKey,
        controller: _controller,
        keyboardType: _keyboardType,
        maxLines: _maxLines,
        validator: validator,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: _hintText,
          hintStyle: TextStyle(fontSize: 16, color: hintColor),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: InputBorder.none,
          suffixIcon: _suffixIcon,
          suffixIconColor: primaryColor,
          errorStyle: const TextStyle(fontSize: 13, height: 0.8),
        ),
      ),
    );
  }
}
