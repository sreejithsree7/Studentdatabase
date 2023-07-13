import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record/functions/fuctions.dart';
import 'package:student_record/models/student_model.dart';
import 'package:student_record/views/Home_Screen/home_screen.dart';

class AddstudentPage extends StatefulWidget {
  AddstudentPage({
    super.key,
  });

  @override
  State<AddstudentPage> createState() => _AddstudentPageState();
}

class _AddstudentPageState extends State<AddstudentPage> {
  String img = '';
  final formKey = GlobalKey<FormState>();

  TextEditingController nameCondroller = TextEditingController();

  TextEditingController ageCondroller = TextEditingController();

  TextEditingController phoneCondroller = TextEditingController();

  TextEditingController emailCondroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue.shade900),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 90,
              ),
              InkWell(
                child: CircleAvatar(
                  minRadius: 80,
                  backgroundImage: img.isEmpty
                      ? AssetImage('assests/user.webp') as ImageProvider
                      : FileImage(File(img)),
                ),
                onTap: () async {
                  XFile? xFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (xFile != null) {
                    img = xFile.path;
                    setState(() {});
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter the name';
                          }
                        },
                        controller: nameCondroller,
                        decoration: InputDecoration(
                            helperText: '',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter the age';
                                }
                              },
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              controller: ageCondroller,
                              decoration: InputDecoration(
                                  helperText: '',
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  prefixIcon: Icon(Icons.calendar_today),
                                  labelText: 'Age',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter the phone';
                                }
                              },
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              controller: phoneCondroller,
                              decoration: InputDecoration(
                                  helperText: '',
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  prefixIcon: Icon(Icons.phone),
                                  labelText: 'Phone',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter the email';
                          }
                        },
                        controller: emailCondroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            helperText: '',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            prefixIcon: Icon(Icons.email_rounded),
                            labelText: 'e-mail',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(MaterialPageRoute(
                          builder: (context) {
                            return HomePage();
                          },
                        ));
                      },
                      child: Text('cancel')),

                  // SizedBox(
                  //   width: 100,
                  // ),
                  ElevatedButton(
                      onPressed: () {
                        if (
                            // ageCondroller.text.trim().isNotEmpty &&
                            //   phoneCondroller.text.trim().isNotEmpty &&
                            //   emailCondroller.text.trim().isNotEmpty
                            formKey.currentState!.validate()) {
                          StudentModel model = StudentModel(
                              name: nameCondroller.text.trim(),
                              age: ageCondroller.text.trim(),
                              phone: phoneCondroller.text.trim(),
                              email: emailCondroller.text.trim(),
                              image: img);

                          addStudent(model);
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('submit')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
