import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final TextEditingController controller;
  final List<String> items;
  final Function onChanged;
  const CustomDropdown({
    super.key,
    required this.controller,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
          isExpanded: true,
          isDense: false,
          value: controller.text,
          items: items.asMap().entries.map((e) {
            return DropdownMenuItem(
              value: e.value,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: Text(e.value),
              ),
            );
          }).toList(),
          onChanged: (value) {
            onChanged(value);
          },
        ),
      ],
    );
  }
}
