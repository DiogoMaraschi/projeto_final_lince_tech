import 'package:flutter/material.dart';
import '../app_colors.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.btnText,
    required this.btnAction,
  });

  final String btnText;
  final VoidCallback btnAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(color: Colors.white),
      child: SizedBox(
        height: 54,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: btnAction,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors().primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check, size: 24),
              const SizedBox(width: 4),
              Text(btnText, style: const TextStyle(fontSize: 22)),
            ],
          ),
        ),
      ),
    );
  }
}
