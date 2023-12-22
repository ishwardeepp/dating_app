
// ignore_for_file: camel_case_types

import 'package:dating_app/button.dart';
import 'package:dating_app/gridview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class uploadScreen extends StatefulWidget {
  const uploadScreen({super.key});

  @override
  State<uploadScreen> createState() => _uploadScreenState();
}

class _uploadScreenState extends State<uploadScreen> {
  List<XFile?> fileList = [null,null,null,null,null,null];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [SizedBox(
            height: 5.h,
          ),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                text: 'And, how good you \nlook',
                style: GoogleFonts.sourceSans3(
                    fontWeight: FontWeight.bold,
                    fontSize: .44.dp,
                    color: Colors.white),
              ),
            ]),
          ),
          gridViewer(fileList),
          SizedBox(
            height: 3.h,
          ),
          Center(child: bottomButton(fileList)),
        ],
      ),
    ));
  }
}