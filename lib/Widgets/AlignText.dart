import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlignText extends StatefulWidget {
  String text ;
  double? size ;
  Color? color ;
  FontWeight? bold ;

  AlignText({Key? key,required this.text,this.size,this.color,this.bold}) : super(key: key);

  @override
  State<AlignText> createState() => _AlignTextState();
}

class _AlignTextState extends State<AlignText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20 ),
      child: Align(alignment: Alignment.topLeft,
        child: Text(widget.text ,style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: widget.size,color: widget.color,fontWeight: widget.bold))),),
    );
  }
}