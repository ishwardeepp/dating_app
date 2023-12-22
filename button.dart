// ignore_for_file: camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class bottomButton extends StatefulWidget {
  final List<XFile?> fileList;
  const bottomButton(this.fileList, {super.key});

  @override
  State<bottomButton> createState() => _bottomButtonState();
}

class _bottomButtonState extends State<bottomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(
            EdgeInsets.all(0.0),
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: (nullcheck() == 0)
            ? () {}
            : () => print("Button pressed"),
        child: Container(
            decoration: (nullcheck() == 0)
                ? const BoxDecoration(
                    color: Color.fromARGB(236, 255, 136, 45),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)))
                : const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color.fromARGB(222, 255, 45, 45),
                        Color.fromARGB(222, 255, 76, 45),
                        Color.fromARGB(222, 255, 122, 45),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
            padding: EdgeInsets.all(20.sp),
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(children: [
                TextSpan(
                  text: 'Start getting matches',
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                      color: Colors.white),
                ),
              ]),
            )));
  }
  int nullcheck(){
    int i=0;
    while(i< widget.fileList.length){
      if(widget.fileList[i] != null){
        return 1;
      }
      else{
        i++;
        return 0;
      }
    }
    return 3;
  }
}