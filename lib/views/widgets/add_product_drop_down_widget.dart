import 'package:flutter/material.dart';

class AddProductDropDownWidget extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const AddProductDropDownWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButton<bool>(
          value: value,
          onChanged: (newValue) => onChanged(newValue!),
          items: const [
            DropdownMenuItem(child: Text("True"), value: true),
            DropdownMenuItem(child: Text("False"), value: false),
          ],
          isExpanded: true,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
