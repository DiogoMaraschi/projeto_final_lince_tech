import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_colors.dart';

class LabeledTextFormField extends StatefulWidget {
  const LabeledTextFormField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.suffixIcon,
    this.validator,
    this.inputFormatters,
    this.fieldKey,
    this.textCapitalization = TextCapitalization.none,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Key? fieldKey;
  final TextCapitalization textCapitalization;

  @override
  State<LabeledTextFormField> createState() => _LabeledTextFormFieldState();
}

class _LabeledTextFormFieldState extends State<LabeledTextFormField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()..addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_handleFocusChange)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 16,
              color: _focusNode.hasFocus
                  ? colors.primary
                  : AppColors.labelColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: colors.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _focusNode.hasFocus
                  ? AppColors.primaryColor
                  : const Color(0xFFE4E4E7),
              width: 1,
            ),
          ),
          child: TextFormField(
            key: widget.fieldKey,
            focusNode: _focusNode,
            controller: widget.controller,
            textCapitalization: widget.textCapitalization,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: 16, color: AppColors.hintColor),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: InputBorder.none,
              suffixIcon: widget.suffixIcon,
              suffixIconColor: AppColors.primaryColor,
              errorStyle: const TextStyle(fontSize: 13, height: 0.8),
            ),
          ),
        ),
      ],
    );
  }
}
