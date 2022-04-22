import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watercooler/models/event_model.dart';
import 'package:watercooler/widgets/big_text.dart';

import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

import 'package:http/http.dart' as http;
import 'package:watercooler/utils/globals.dart' as globals;

class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();

  TextEditingController month = TextEditingController();
  TextEditingController day = TextEditingController();
  TextEditingController year = TextEditingController();

  TextEditingController hour = TextEditingController();
  TextEditingController minute = TextEditingController();

  var imageFile;

  addEvent() async {
    print("addEvent pressed");
    try {
      Event request = Event(
          title: title.text.isEmpty ? '' : title.text,
          description: description.text.isEmpty ? '' : description.text,
          date: month.text.isEmpty || day.text.isEmpty || year.text.isEmpty
              ? ''
              : '${month.text}/${day.text}/${year.text}',
          location: location.text.isEmpty ? '' : location.text,
          time: hour.text.isEmpty || minute.text.isEmpty
              ? ''
              : '${hour.text}/${minute.text}',
          imageUri: imageFile != null ? imageFile.toString() : '',
          id: 0);

      var response = await http.post(
          Uri.parse(AppConstants.BASE_URL + AppConstants.EVENTS_URI),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: jsonEncode(request.toJson()));
      if (response.statusCode == 200) {
        const snackbar = SnackBar(content: Text("Event Added"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        Get.toNamed(RouteHelper.getHome());
      } else {
        const snackbar = SnackBar(content: Text("Error adding event"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
      print(response.body);
    } catch (e) {
      print('ERROR: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getHome());
                },
                child: const Icon(
                  Icons.arrow_circle_left_outlined,
                  color: AppColors.textColor,
                  size: 40.0,
                ),
              ),
            ),
            const SizedBox(height: 5),
            // title
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Add Event",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  // title textfield
                  TextFormField(
                    controller: title,
                    obscureText: false,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      labelText: 'Title',
                    ),
                  ),
                  const SizedBox(height: 10),
                  // description textfield
                  TextFormField(
                    controller: description,
                    obscureText: false,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      labelText: 'Description',
                    ),
                  ),
                  // date selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // description textfield
                      SizedBox(
                        width: 40,
                        child: TextFormField(
                          controller: month,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          obscureText: false,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 10, bottom: 10, top: 10),
                            labelText: 'M',
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          controller: day,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          obscureText: false,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 10, bottom: 10, top: 10),
                            labelText: 'D',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: TextFormField(
                          controller: year,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          obscureText: false,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 10, bottom: 10, top: 10),
                            labelText: 'Y',
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        margin: const EdgeInsets.only(left: 45, right: 10),
                        child: TextFormField(
                          controller: hour,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          obscureText: false,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 10, bottom: 10, top: 10),
                            labelText: 'H',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: TextFormField(
                          controller: minute,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          obscureText: false,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 10, bottom: 10, top: 10),
                            labelText: 'M',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // description textfield
                  TextFormField(
                    controller: location,
                    obscureText: false,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      labelText: 'Location',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _getFromGallery();
                        },
                        child: Center(
                          child: Container(
                            width: Dimensions.width45,
                            height: Dimensions.height45,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: Dimensions.iconSize24,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Dimensions.radius15,
                              ),
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      imageFile != null
                          ? SizedBox(
                              height: 100,
                              child: Image.file(
                                imageFile,
                                fit: BoxFit.cover,
                              ),
                            )
                          : BigText(text: "Select A Photo")
                    ],
                  ),
                  const SizedBox(height: 10),
                  // add button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          addEvent();
                        },
                        style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: AppColors.textColor,
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 15, left: 30, right: 30)),
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Get from gallery
  _getFromGallery() async {
    // Pick an image
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    } else {
      const snackbar =
          SnackBar(content: Text("Sorry, that image is not acceptable"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  // Get from Camera
  _getFromCamera() async {
    // Capture a photo
    final XFile? photoTaken =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (photoTaken != null) {
      setState(() {
        imageFile = File(photoTaken.path);
      });
    } else {
      const snackbar =
          SnackBar(content: Text("Sorry, that image is not acceptable"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
