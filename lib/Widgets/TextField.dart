import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomTextfield extends StatefulWidget {
  double? containerHeight ;
  double? containerWidth ;
  int? maxLength ;
  String? labelText ;
  double? fontsize ;
  double? labelSize ;
  int? maxLines ;
  String hintText ;
  String? label ;
  TextEditingController controller = TextEditingController();
   CustomTextfield({Key? key,required this.controller,this.label,this.maxLength,this.containerHeight,this.containerWidth,this.labelSize,required this.hintText,this.maxLines,this.fontsize}) : super(key: key);

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return  Align(alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Container(height: widget.containerHeight,width: widget.containerWidth,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: TextFormField(
            style: TextStyle(fontSize: widget.fontsize),
            controller: widget.controller,
              maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
              labelText: widget.label,
              labelStyle: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.black38,fontSize: widget.labelSize)),

              hintText: widget.hintText,
              hintStyle: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.black38)),
              contentPadding:
              const EdgeInsets.only(left: 14, bottom: 8, top: 8),
              focusedBorder: OutlineInputBorder(
                borderSide:  const BorderSide(color: Colors.greenAccent),
                borderRadius:  BorderRadius.circular(25),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide:  const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
