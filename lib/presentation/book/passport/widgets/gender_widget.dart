import 'package:flutter/material.dart';
import 'package:griffin/presentation/common/colors.dart';

class GenderSelectionWiget extends StatefulWidget {
  const GenderSelectionWiget({super.key});

  @override
  State<GenderSelectionWiget> createState() => _GenderSelectionWigetState();
}

class _GenderSelectionWigetState extends State<GenderSelectionWiget> {
  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            isMaleSelected = !isMaleSelected;
            setState(() {});
          },
          icon: isMaleSelected
              ? const Icon(Icons.check_circle, color: AppColors.orangeColor)
              : const Icon(Icons.circle_outlined, size: 20),
        ),
        const Text('Male'),
        const SizedBox(width: 40),
        IconButton(
          onPressed: () {
            isFemaleSelected = !isFemaleSelected;
            setState(() {});
          },
          icon: isFemaleSelected
              ? const Icon(Icons.check_circle, color: AppColors.orangeColor)
              : const Icon(Icons.circle_outlined, size: 20),
        ),
        const Text('Female')
      ],
    );
  }
}
