import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => ImageUploadState();
}

class ImageUploadState extends State<ImageUpload> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    //picked an image
    final PickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    //converting pickedFile into file
    if (PickedFile != null) {
      image = File(PickedFile.path);
      // setState(() {});
    } else {
      print('select your image');
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    //main code for the multipart request
    var request = new http.MultipartRequest('post', uri);
    request.fields['title'] = 'static title';
    var multiport = new http.MultipartFile('image', stream, length);
    request.files.add(multiport);
    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      // Fluttertoast.showToast(
      //     msg: 'Uploaded succesfully',
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
      print('uploaded succesfully');
    } else {
      setState(() {
        showSpinner = false;
        // Fluttertoast.showToast(
        //     msg: 'Upload failed',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
        print('failed');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Upload image'),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         setState(() {});
          //       },
          //       icon: Icon(Icons.refresh))
          // ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: image == null
                    ? GestureDetector(
                        onTap: getImage,
                        child: Container(
                          child: Center(
                            child: Text('Pick image'),
                          ),
                        ),
                      )
                    : Container(
                        child: Center(
                          child: Image.file(
                            File(image!.path).absolute,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
            SizedBox(
              height: 150,
            ),
            GestureDetector(
              onTap: uploadImage,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    'Upload',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
