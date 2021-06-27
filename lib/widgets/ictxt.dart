import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IcTxtWidget extends StatelessWidget {
  final Color? backgroundColor;
  final IconData icon;
  final String text;

  IcTxtWidget({
    required this.backgroundColor,
    required this.icon,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 7.0,
        vertical: 5.0,
      ),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 18.0,
          ),
          SizedBox(width: 5.0),
          Text(
            text,
            style: GoogleFonts.raleway(
              color: Colors.white,
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
