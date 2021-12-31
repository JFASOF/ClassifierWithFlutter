import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_classifier_cd/constants/app_constants.dart';
import 'package:flutter_classifier_cd/widgets/gestureDetector.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  bool? _isLoading = false;
  List? _output;

  _pickImage() async {
    var image = await ImagePicker.platform.getImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    }
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image!);
  }

  _pickGallery() async {
    var image =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image!);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    loadModel().then((value) {});
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  classifyImage(File image) async {
    var outputImage = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _isLoading = false;
      _output = outputImage;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/label.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              AppConstants.homeTitle,
              style: TextStyle(color: Colors.deepOrange[400], fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              AppConstants.detectObject,
              style: TextStyle(color: Colors.deepOrange[400], fontSize: 25),
            ),
            Center(
                child: _isLoading!
                    ? Container(
                        width: 300,
                        child: Column(children: [
                          Image.asset("assets/cat.png"),
                          const SizedBox(
                            height: 50,
                          )
                        ]),
                      )
                    : Container(
                        child: Column(
                          children: [
                            Container(
                              child: Image.file(_image!),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _output!=null ? Text('${_output![0]['label']}',style: TextStyle(color:Colors.deepOrange[400],fontSize: 20.0 )):Container()
                          ],
                        ),
                      )),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PhotoGesture(
                            label: "Take a photo", onTap: () => _pickImage()),
                        PhotoGesture(
                            label: "Pick a gallery",
                            onTap: () => _pickGallery()),
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
