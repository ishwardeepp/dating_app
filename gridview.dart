// ignore_for_file: camel_case_types

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class gridViewer extends StatefulWidget {
  final List<XFile?> fileList;
  const gridViewer(this.fileList, {super.key});

  @override
  State<gridViewer> createState() => _gridViewerState();
}

class _gridViewerState extends State<gridViewer> {
  int count = -1;
  XFile? image;
  bool choice = true;

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 45.w,
            childAspectRatio: 1,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 2.h),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: widget.fileList[index] == null
                ? () {}
                : () => bottomSheet(false, index),
            child: Container(
              height: 30.h,
              width: 45.w,
              padding: EdgeInsets.all(8.0.sp),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.white, style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(20.sp))),
              child: widget.fileList[index] == null
                  ? IconButton(
                      icon: const Icon(Icons.add_circle_outline_sharp),
                      color: Colors.white,
                      iconSize: 30.sp,
                      onPressed: () async => await bottomSheet(true, index),
                    )
                  : Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                        child: Image.file(
                          File(widget.fileList[index]!.path),
                          fit: BoxFit.fill,
                          width: 46.w,
                          height: 31.h,
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              icon: const Icon(Icons.delete_outline),
                              color: const Color.fromARGB(222, 255, 45, 45),
                              iconSize: 25.sp,
                              onPressed: () => fileDel(index)))
                    ]),
            ),
          );
        },
      ),
    );
  }

  Future<void> fileAdd(ImageSource media, int index) async {
    List<XFile> tempLst = await picker.pickMultiImage();
    if (tempLst.isEmpty) {
      return;
    }
    for (int count = index; widget.fileList[count] == null; count++) {
      setState(() {
        widget.fileList[count] = tempLst.removeAt(0);
      });
      if (tempLst.isEmpty) {
        break;
      }
    }
  }

  Future<void> fileDel(int index) async {
    setState(() {
      widget.fileList[index] = null;
    });
  }

  Future<void> fileRep(ImageSource media, int index) async {
    XFile? img = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      widget.fileList[index] = img;
    });
  }

  Future<void> fileCam(ImageSource media, int index) async {
    XFile? img = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      widget.fileList[index] = img;
    });
  }

  Future<void> bottomSheet(bool choice, int pos) {
    return showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
                title: (choice == true)
                    ? const Text('Upload Your Picture')
                    : const Text('Remove Picture'),
                message: (choice == true)
                    ? const Text(
                        'Make sure your face is visible in the picture.')
                    : const Text(
                        'Replace or Delete picture from your profile.'),
                actions: <Widget>[
                  CupertinoActionSheetAction(
                    onPressed: widget.fileList[pos] == null
                        ? () async => await fileCam(ImageSource.camera, pos)
                        : () async => await fileRep(ImageSource.gallery, pos),
                    child: (choice == true)
                        ? const Text('Take a picture')
                        : const Text('Replace a picture'),
                  ),
                  (choice == true)
                      ? CupertinoActionSheetAction(
                          child: const Text('Upload from your Camera Roll'),
                          onPressed: () async =>
                              await fileAdd(ImageSource.gallery, pos),
                        )
                      : CupertinoActionSheetAction(
                          isDestructiveAction: true,
                          child: const Text('Delete picture'),
                          onPressed: () async => await fileDel(pos),
                        )
                ]));
  }
}
