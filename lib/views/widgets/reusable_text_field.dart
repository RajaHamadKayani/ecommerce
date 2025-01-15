import 'package:flutter/material.dart';

class ReusableTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;
  final Icon suffixIcon;
  final FocusNode? focusNode; // Focus node for managing field focus
  final TextInputAction textInputAction; // Action for the keyboard button
  final void Function(String)? onFieldSubmitted; // Callback when "Done" is pressed

  ReusableTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.suffixIcon,
    required this.title,
    this.focusNode, // Optional focus node
    this.textInputAction = TextInputAction.done, // Default action
    this.onFieldSubmitted, // Optional callback
  });

  @override
  State<ReusableTextFieldWidget> createState() =>
      _ReusableTextFieldWidgetState();
}

class _ReusableTextFieldWidgetState extends State<ReusableTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              fontFamily: "Pulp"),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: TextFormField(
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Pulp",
                  fontSize: 14),
              controller: widget.controller,
              focusNode: widget.focusNode, // Assign the focus node
              textInputAction: widget.textInputAction, // Set keyboard action
              onFieldSubmitted: widget.onFieldSubmitted, // Handle field submission
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 15),
                suffixIcon: widget.suffixIcon,
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Pulp",
                    fontSize: 14),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
