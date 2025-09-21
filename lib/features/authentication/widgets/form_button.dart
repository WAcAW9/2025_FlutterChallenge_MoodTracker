import 'package:flutter/material.dart';
import 'package:mood_tracker/features/constants/gaps.dart';

class FormButton extends StatelessWidget {
  const FormButton({super.key, required this.disabled});

  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
        decoration: BoxDecoration(
          color: disabled ? Colors.grey : Colors.black,
          borderRadius: BorderRadius.circular(Sizes.size5),
        ),
        duration: const Duration(milliseconds: 500),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 500),
          style: TextStyle(
            color: disabled ? Colors.grey.shade400 : Colors.white,
            fontWeight: FontWeight.w600,
          ),
          child: const Text('Next', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
