import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResuableTextFormField1 extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;
  final FocusNode? focusNode; // Focus node for managing field focus
  final TextInputAction textInputAction; // Action for the keyboard button
  final void Function(String)? onFieldSubmitted; // Callback when "Done" is pressed

  ResuableTextFormField1({
    super.key,
    required this.controller,
    required this.hintText,
    required this.title,
    this.focusNode, // Optional focus node
    this.textInputAction = TextInputAction.done, // Default action
    this.onFieldSubmitted, // Optional callback
  });

  @override
  State<ResuableTextFormField1> createState() =>
      _ResuableTextFormField1State();
}

class _ResuableTextFormField1State extends State<ResuableTextFormField1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(widget.title,
        style: GoogleFonts.raleway(color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w800),),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: Color(0xffF8F8F8)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: TextFormField(
              style :GoogleFonts.poppins(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              controller: widget.controller,
              focusNode: widget.focusNode, // Assign the focus node
              textInputAction: widget.textInputAction, // Set keyboard action
              onFieldSubmitted: widget.onFieldSubmitted, // Handle field submission
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 5),
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: GoogleFonts.poppins(
                    color: Color(0xffD2D2D2),
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20,)
      ],
    );
  }
}
