import 'package:flutter/material.dart';

import '../app_colors.dart';

class CommomTextField extends StatelessWidget {
  CommomTextField({
    super.key,
    required this._controller,
    required this._hintText,
    this._keyboardType = TextInputType.text,
    this._maxLines = 1,
    this._suffixIcon,
  });

  final TextEditingController _controller;
  final String _hintText;
  final TextInputType _keyboardType;
  final int _maxLines;
  final Widget? _suffixIcon;

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
      child: TextField(
        controller: _controller,
        keyboardType: _keyboardType,
        maxLines: _maxLines,
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
        ),
      ),
    );
  }
}
