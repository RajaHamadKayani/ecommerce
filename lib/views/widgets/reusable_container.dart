import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableContainer extends StatelessWidget {
  String title;
  int color;
  BorderRadius borderRadius;

  ReusableContainer(
      {super.key,
      required this.borderRadius,
      required this.color,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Color(color),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15,
        horizontal: 11),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.nunitoSans(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
