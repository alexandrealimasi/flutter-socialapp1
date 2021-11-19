import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app1/screens/home_page.dart';
import 'package:social_app1/services/http/http_helper.dart';
import 'package:social_app1/utils/_shared_preferences.dart';
import 'dart:developer' as dev;

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  HttpHelper httpHelper = HttpHelper();
  bool circular = false;
  final _globalkey = GlobalKey<FormState>();
  PickedFile? imageFile;
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  File? file;
  pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        file = File(result.files.single.path!);
        setState(() {});
      } else {
        dev.log('err');
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      circular = false;
    }
  }

  savefiles() async {
    Map<String, dynamic> data = {
      "title": _title.text,
      "description": _description.text
    };
    var response = await HttpHelper.fileUploadPostRequest(
        '${HttpHelper.baseUrl}/posts?Authorization=Bearer ${UserPreferences.token}',
        [file!.path],
        body: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      dev.log(response.toString());
    } else {
      dev.log(response.requestOptions.baseUrl.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _globalkey,
        child: Column(
          children: [
            Stack(
              children: [
                Icon(Icons.edit),
                Container(
                  child: InkWell(
                    onTap: () {
                      pickImage();
                    },
                    child: CircleAvatar(
                      backgroundImage: file == null ? null : FileImage(file!),
                      radius: 50,
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: _title,
            ),
            TextField(
              controller: _description,
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  savefiles();
                },
                child: Text("Save"))
          ],
        ),
      ),
    );
  }
}
